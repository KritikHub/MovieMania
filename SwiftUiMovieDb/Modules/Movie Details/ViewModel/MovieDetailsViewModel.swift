//
//  MovieDetailsViewModel.swift
//  SwiftUiMovieDb
//
//  Created by mac on 24/11/23.
//

import SwiftUI

enum ViewState<T: Decodable> {
    case loading
    case success(data: T)
    case error(MDBError)
}

class MovieDetailsViewModel: ObservableObject {    
    
    @Published var movieDetails: MovieDetails?
    @Published var isLoading = false
    @Published var error: MDBError?
    
    @Published var viewState: ViewState<MovieDetails> = .loading
    
    let service = APIService()
    
    func loadMovie(with id: Int) {
         self.movieDetails = nil
         self.isLoading = false
        let params = generateParameterForMovieDetails()
        let urn = MovieDetailsURN(id: id, parameters: params)
         self.service.makeRequest(with: urn) {[weak self] (result) in
             guard let self = self else { return }
             DispatchQueue.main.async {
             self.isLoading = false
             switch result {
             case .success(let response):               
                self.movieDetails = response
                self.viewState = .success(data: response)
             case .failure(let error):
                 self.error = error
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
