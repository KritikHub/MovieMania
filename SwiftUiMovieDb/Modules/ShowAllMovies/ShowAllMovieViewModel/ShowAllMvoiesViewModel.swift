//
//  ShowAllMvoiesViewModel.swift
//  SwiftUiMovieDb
//
//  Created by mac on 24/11/23.
//

import Foundation

class ShowAllMoviesViewModel: ObservableObject {
    
    var movies: [Movie] = []
    var prevPageNo = 1
    
    @Published var viewState: ViewState<[Movie]> = .loading
    
    let service = APIService()
    
    func loadMovies(with movieType: MovieListType, pageNo: Int) {
        viewState = .loading
        let param = generateParameterForMovieDetails(pageNo: pageNo)
        let urn = MovieListURN(movieType: movieType, parameters: param)
        guard pageNo == prevPageNo || pageNo < prevPageNo else {
            return
        }
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
    
    private func generateParameterForMovieDetails(pageNo: Int) -> [String: String] {
        var parameters: [String: String] = [:]
        
        parameters[Parameter.page.rawValue] = "\(pageNo)"
        return parameters
    }
}
