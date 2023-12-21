//
//  SearchMovieViewModel.swift
//  SwiftUiMovieDb
//
//  Created by mac on 04/12/23.
//

import SwiftUI
import Combine
import Foundation

class MovieSearchViewModel: ObservableObject {
    
    @Published var query = ""
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var error: MDBError = .unknown
    
    private var subscriptionToken: AnyCancellable?
    
    let service = APIService()
    
    func startObserve() {
        guard subscriptionToken == nil else { return }
        
        self.subscriptionToken = self.$query
            .map { text in              
                return text
            }
            .throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] in self?.search(query: $0) }
    }
    
    func search(query: String) {
        
        isLoading = false
        let param = generateParameterForMovieDetails(query: query)
        let urn = SearchMovieURN(parameters: param)
        
        guard !query.isEmpty else {
            movies = []
            return
        }
        
        self.isLoading = true
        self.service.makeRequest(with: urn) {[weak self] (result) in
            guard let self = self, self.query == query else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):                 
                    self.movies = response.results
                case .failure(let error):
                    self.error = error
                    
                }
            }
        }
    }
    
    deinit {
        self.subscriptionToken?.cancel()
        self.subscriptionToken = nil
    }
    
    private func generateParameterForMovieDetails(query: String) -> [String: String] {
        var parameters: [String: String] = [:]        
        parameters[Parameter.query.rawValue] = query
        return parameters
    }
}
