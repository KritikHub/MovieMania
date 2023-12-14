//
//  MovieDetailsViewModel.swift
//  SwiftUiMovieDb
//
//  Created by mac on 24/11/23.
//

import SwiftUI

final class MovieDetailsViewModel: ObservableObject {
    
    @Published var viewState: ViewState<MovieDetails> = .loading
    var favoriteMovieResponse = FavoriteMovieResponse(success: "", status_code: 0, status_message: "")
    var error: MDBError = .unknown
    
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
    
    func addFavoriteMovie(id: Int, isAddToFavorite: Bool) {
        let data = favoriteMovieBody(id: id, isAddToFavorite: isAddToFavorite)
        do {
            let bodyParam = try JSONSerialization.data(withJSONObject: data)
            let urn = AddToFavoriteURN(body: bodyParam)
            self.service.makeRequest(with: urn) {[weak self] (result) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self.favoriteMovieResponse = response
                    case .failure(let error):
                        self.error = error
                    }
                }
            }
        } catch {
            self.error = error as! MDBError
        }
    }
    
    private func generateParameterForMovieDetails() -> [String: String] {
        var parameters: [String: String] = [:]
        parameters[Parameter.movieDetails.rawValue] = "videos,credits"
        return parameters
    }
    
    private func favoriteMovieBody(id: Int, isAddToFavorite: Bool) -> [String: Any] {
        var body: [String: Any] = [:]
        body[Body.mediaType.rawValue] = "movie"
        body[Body.mediaId.rawValue] = id
        body[Body.favorite.rawValue] = isAddToFavorite
        return body
    }
}

func isRatingAvailable(movie: MovieDetails) -> Bool {
    return movie.ratingText.isEmpty
}

func isCrewDetailsAvailable(movie: MovieDetails) -> Bool {
    return movie.crew != nil && movie.crew!.count > 0
}

func isDirectorsDetailsAvailable(movie: MovieDetails) -> Bool {
    return movie.directors != nil && movie.directors!.count > 0
}

func isProducersDetailsAvailable(movie: MovieDetails) -> Bool {
    return movie.producers != nil && movie.producers!.count > 0
}

func isScreenWritersDetailsAvailable(movie: MovieDetails) -> Bool {
    return movie.screenWriters != nil && movie.screenWriters!.count > 0
}

func isYoutubeTrailerAvailable(movie: MovieDetails) -> Bool {
    return movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0
}
