//
//  ShowAllMvoiesViewModel.swift
//  SwiftUiMovieDb
//
//  Created by mac on 24/11/23.
//

import Foundation

class ShowAllMoviesViewModel: ObservableObject {
        
    @Published var isLoading: Bool = false
    @Published var movies: [Movie] = []
    @Published var error: MDBError = .unknown
    
    private var currentPage: Int = .zero
    
    var isLoadingFirstTime: Bool = true
    
    let service = APIService()
    
    func loadMovies(with movieType: MoviesCategory, from nextPage: Int) {
        
        let param = generateParameterForMovieDetails(pageNo: nextPage)
        let urn = MovieListURN(movieType: movieType, parameters: param)
        guard nextPage > currentPage else {
            return
        }
        isLoading = true
        self.service.makeRequest(with: urn) {[weak self] (result) in
            guard let self = self else { return }
            self.isLoadingFirstTime = false
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.movies.append(contentsOf: response.results)
                    self.currentPage = nextPage
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    private func generateParameterForMovieDetails(pageNo: Int) -> [String: String] {
        var parameters: [String: String] = [:]
        
        parameters[Parameter.page.rawValue] = "\(pageNo)"
        return parameters
    }
    func isLastItem(movieId: Int) -> Bool{
        let lastmovie = movies.last
        guard movieId == lastmovie?.id && movies.last != nil else {
            return false
        }
        return true
    }
}
