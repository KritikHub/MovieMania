//
//  ShowAllMoviesView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 24/11/23.
//

import SwiftUI

struct ShowAllMoviesView: View {
    
    @StateObject private var viewModel = ShowAllMoviesViewModel()
    
    var viewState: ViewState<[Movie]> {
        return viewModel.viewState
    }
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var movieCardWidth: CGFloat {
        (screenWidth - 2 * 16 - 16) / 2
    }
    
    private var columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible())]
    
    private var allMovies: [Movie] {
        return viewModel.movies
    }
     
//    private Var showLoader: some View {
//         LoadingMDBView
//    }
    
    var body: some View {
      mainContent
    }
    
    @ViewBuilder
    private var mainContent: some View {
        switch viewState {
        case .loading:
            LoadingMDBView(isLoading: true, error: <#T##MDBError?#>, retryAction: <#T##(() -> ())?##(() -> ())?##() -> ()#>)
        case .success(data: <#T##[Movie]#>):
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(allMovies) { movie in
                        ShowMovieCardView(movie: movie)
                            .onAppear {
                                //TODO: Need to implement load more!
                            }
                            .frame(width: movieCardWidth)
                    }
                }
                .padding(.horizontal, 16)
                .onAppear {
                   viewModel.loadMovies(with: .now_playing, pageNo: 1)
                }
            }
        }
    }
}

struct ShowAllMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllMoviesView()
    }
}
