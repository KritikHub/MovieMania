//
//  MovieListView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 03/08/23.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var movieListState = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                movieSection(title: "Now Playing", movieType: .now_playing)
                movieSection(title: "Upcoming", movieType: .upcoming)
                movieSection(title: "Top Rated", movieType: .top_rated)
                movieSection(title: "Popular", movieType: .popular)
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

private func movieSection(title: String, movieType: MovieListType) -> some View {
    Group {
        if movieListState.movies != nil {
            if movieType == .now_playing {
                MoviePosterCarouselView(title: title, movies: movieListState.movies!)
            } else {
                MovieBackdropCarouselView(title: title, movies: movieListState.movies!)
            }
            }else {
                LoadingMDBView(isLoading: self.movieListState.isLoading, error: self.movieListState.error) {
                    self.movieListState.loadMovies(with: movieType)
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
