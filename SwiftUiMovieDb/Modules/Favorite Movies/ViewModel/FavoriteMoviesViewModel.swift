//
//  FavoriteMoviesViewModel.swift
//  SwiftUiMovieDb
//
//  Created by mac on 19/12/23.
//

import Foundation

class FavoriteMoviesViewModel: ObservableObject {
    
    @Published var viewState: ViewState<[FavoriteMovie]> = .loading
    private let firebaseClient = FirebaseClient()
    
    func getFavoriteMovies() {
        firebaseClient.getFavoriteList(completion: { result in
            switch result {
            case .success(let data):
                self.viewState = .success(data: data)
            case .failure(let error):
                self.viewState = .error(error)
            }
        })
    }
}
