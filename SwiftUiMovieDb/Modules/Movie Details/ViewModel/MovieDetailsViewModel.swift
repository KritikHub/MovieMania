//
//  MovieDetailsViewModel.swift
//  SwiftUiMovieDb
//
//  Created by mac on 24/11/23.
//

import SwiftUI

class MovieDetailsViewModel: ObservableObject {
    
    @Published var viewState: ViewState<MovieDetails> = .loading
    
    let service = APIService()
    
    func loadMovie(with id: Int) {
        let params = generateParameterForMovieDetails()
        let urn = MovieDetailsURN(id: id, parameters: params)
        self.service.makeRequest(with: urn) {[weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.viewState = .success(data: response)
                case .failure(let error):
                    self.viewState = .error(error)
                }
            }
        }
    }
    
    private func generateParameterForMovieDetails() -> [String: String] {
        var parameters: [String: String] = [:]
        
        parameters[Parameter.movieDetails.rawValue] = "videos,credits"
        return parameters
    }
}
