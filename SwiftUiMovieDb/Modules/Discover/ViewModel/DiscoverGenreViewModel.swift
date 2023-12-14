//
//  DiscoverGenreViewModel.swift
//  SwiftUiMovieDb
//
//  Created by mac on 06/12/23.
//

import SwiftUI

class DiscoverGenreViewModel: ObservableObject {
    
    @Published var viewState: ViewState<[Movie]> = .loading
    var movies: [Movie] = []
    
    let service = APIService()
    
    func loadMovies(with genreType: GenreType, genreId: Int, nextPageNo: Int) {
        
        let param = generateParameterForMovieDetails(genreId: genreId)
        let urn = DiscoverURN(genreType: genreType, parameters: param)
        
        self.service.makeRequest(with: urn) {[weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.movies.append(contentsOf: response.results)
                    self.viewState = .success(data: self.movies)
                case .failure(let error):
                    self.viewState = .error(error)
                }
            }
        }
    }
    
    func isLastItem(movieId: Int) -> Bool{
        let lastmovie = movies.last
        guard movieId == lastmovie?.id && movies.last != nil else {
            return false
        }
        return true
    }
}

private func generateParameterForMovieDetails(genreId: Int) -> [String: String] {
    var parameters: [String: String] = [:]
    parameters[Parameter.with_genres.rawValue] = "\(genreId)"
    return parameters
}


