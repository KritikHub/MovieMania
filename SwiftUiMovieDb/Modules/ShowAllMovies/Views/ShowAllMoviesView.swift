//
//  ShowAllMoviesView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 24/11/23.
//

import SwiftUI

struct ShowAllMoviesView: View {
    
    @StateObject private var viewModel = ShowAllMoviesViewModel()
    @State var prevPageNo = 1
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var movieCardWidth: CGFloat {
        (screenWidth - 2 * 16 - 16) / 2
    }
    
    private var nextPageNo: Int {
        prevPageNo = prevPageNo + 1
        return prevPageNo
    }
    
    private var columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible())]
    
    private var allMovies: [Movie] {
        return viewModel.movies
    }
    
    private var isLoadingMoreData: Bool {
        return viewModel.isLoading && !viewModel.isLoadingFirstTime
    }
    
    var body: some View {
        mainContent
            .showLoader(viewModel.isLoadingFirstTime)
            .onAppear {
                viewModel.loadMovies(with: .now_playing, from: 1)
            }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.movies, id: \.uniqueID) { movie in
                    NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                        MovieCardView(name: movie.nameValue, url: movie.posterURL)
                            .onAppear { handleLoadMore(movie) }
                            .frame(width: movieCardWidth)
                    }
                }
            }
            .padding(.horizontal, 16)
            if isLoadingMoreData {
                ProgressView()
            }
        }
    }
    
    func handleLoadMore(_ movie: Movie) {
        if viewModel.isLastItem(movieId: movie.id) {
            self.viewModel.loadMovies(
                with: .now_playing,
                from: nextPageNo
            )
        }
    }
}

struct ShowAllMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllMoviesView()
    }
}
