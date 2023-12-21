//
//  GenreViewModel.swift
//  SwiftUiMovieDb
//
//  Created by mac on 05/12/23.
//

import SwiftUI

final class GenreViewModel: ObservableObject {
    
    @Published var viewState: ViewState<[GenreItem]> = .loading
    
    let service = APIService()
    
    func loadMovie(with genre: GenreType) {
       
        let urn = GenreURN(genreType: genre)
        self.service.makeRequest(with: urn) {[weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.viewState = .success(data: response.genres)
                case .failure(let error):
                    self.viewState = .error(error)
                }
            }
        }
    }
}

enum GenreType {
    case movies
    case TvSeries
    
    var title: String {
        switch self {
        case .movies:
            return "Movies"
        case .TvSeries:
            return "Tv-Series"
        }
    }
}
