//
//  MovieListManager.swift
//  SwiftUiMovieDb
//
//  Created by mac on 06/11/23.
//

import SwiftUI

class MovieListViewModel: ObservableObject {    
    
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: MDBError?
    
    let service = APIService()
    
   func loadMovies(with movieType: MovieListType) {
        self.movies = nil
        self.isLoading = false
    let urn = MovieListURN(movieType: movieType)
        self.service.makeRequest(with: urn) {[weak self] (result) in
            guard let self = self else { return }
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
}

enum MovieListType {
    case now_playing
    case upcoming
    case top_rated
    case popular
}
