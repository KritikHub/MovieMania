//
//  SearchMovie.swift
//  SwiftUiMovieDb
//
//  Created by mac on 04/12/23.
//

import SwiftUI

struct SearchMovieView: View {
    
    @StateObject var viewModel = MovieSearchViewModel()
    
    private let placeholderString: String = "Search movies"
    
    private var columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible())]
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var movieCardWidth: CGFloat {
        (screenWidth - 2 * 16 - 16) / 2
    }
    
    var body: some View {
        SearchMovieContentView
            .showLoader(viewModel.isLoading, tint: .gray, background: .white)
            .onAppear {
                self.viewModel.startObserve()
            }
    }
    
    private var searchBar: some View {
        SearchBarView(placeholder: placeholderString, text: self.$viewModel.query)
    }
    
    @ViewBuilder
    private var SearchMovieContentView: some View {
        NavigationView {
            VStack {
                searchBar
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.movies, id: \.uniqueID) { movie in
                            NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                                MovieCardView(name: movie.nameValue, url: movie.posterURL)
                                    .frame(width: movieCardWidth)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


