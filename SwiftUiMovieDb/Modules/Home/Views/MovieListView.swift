//
//  MovieListView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 03/08/23.
//

import SwiftUI

struct MovieListView: View {
    
    @StateObject private var movieListState = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(MovieListType.allCases, id: \.self) {
                    movieSection(movieType: $0)
                }
            }
            .navigationBarTitle("The MovieDb")
        }
        .onAppear {
            self.movieListState.loadMovies(with: .now_playing)
            self.movieListState.loadMovies(with: .upcoming)
            self.movieListState.loadMovies(with: .top_rated)
            self.movieListState.loadMovies(with: .popular)
        }
    }
    
    private func movieSection(movieType: MovieListType) -> some View {
        Group {
            if movieListState.movies.isEmpty {
                LoadingMDBView(isLoading: self.movieListState.isLoading, error: self.movieListState.error) {
                    self.movieListState.loadMovies(with: movieType)
                }
            } else {
                if movieType == .now_playing {
                    MoviePosterCarouselView(title: movieType.title, movies: movieListState.movies)
                } else {
                    MovieBackdropCarouselView(title: movieType.title, movies: movieListState.movies)
                }
            }
        }
        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
    }
}
struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
