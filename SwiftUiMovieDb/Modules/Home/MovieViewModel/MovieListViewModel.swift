//
//  MovieListManager.swift
//  SwiftUiMovieDb
//
//  Created by mac on 06/11/23.
//

import SwiftUI

final class MovieListViewModel: ObservableObject {
    
    @Published var viewState: ViewState<[MoviesCategory:[Movie]]> = .loading
    
    private var moviesWithCategories: [MoviesCategory:[Movie]] = [:]
    
    let service = APIService()
    
    let group = DispatchGroup()
    
    func loadAllMovies() {
        MoviesCategory.allCases.forEach { category in
           self.loadMovies(with: category)
        }
    }
    
    private func loadMovies(with movieType: MoviesCategory) {
        let urn = MovieListURN(movieType: movieType)
        self.group.enter()
        viewState = .loading
        self.service.makeRequest(with: urn) {[weak self] (result) in
            guard let self = self else { return }
            self.group.leave()
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.moviesWithCategories[movieType] = response.results
                    if self.moviesWithCategories.count == MoviesCategory.allCases.count {
                        self.group.notify(queue: .main) {
                            print("All movies loaded successfully! \(self.moviesWithCategories.keys)")
                            self.viewState = .success(data: self.moviesWithCategories)
                        }
                    }
                case .failure(let error):
                    self.viewState = .error(error)
                }
            }
        }
    }
}

enum MoviesCategory: CaseIterable, Decodable {
    case now_playing
    case upcoming
    case top_rated
    case popular
    
    var title: String {
        switch self {
        case .now_playing:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .top_rated:
            return "Top rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}
