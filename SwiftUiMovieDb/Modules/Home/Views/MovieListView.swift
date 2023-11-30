//
//  MovieListView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 03/08/23.
//

import SwiftUI

struct MovieListView: View {
    
    @StateObject private var manager = MovieListViewModel()
    
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
            self.manager.loadMovies(with: .now_playing)
            self.manager.loadMovies(with: .upcoming)
            self.manager.loadMovies(with: .top_rated)
            self.manager.loadMovies(with: .popular)
        }
    }
    
    private func movieSection(movieType: MovieListType) -> some View {
        Group {
            if manager.movies.isEmpty {
                loaderView
            } else {
                if movieType == .now_playing {
                    MoviePosterCarouselView(title: movieType.title, movies: manager.movies)
                } else {
                    MovieBackdropCarouselView(title: movieType.title, movies: manager.movies)
                }
            }
        }
        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
    }
    
    private var loaderView: some View {
        Color.clear
            .showLoader(true, tint: .gray, background: .white)
    }
}
struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
