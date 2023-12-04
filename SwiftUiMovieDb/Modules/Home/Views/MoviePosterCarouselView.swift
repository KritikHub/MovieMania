//
//  MoviePosterCarouselView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 03/08/23.
//

import SwiftUI

struct MoviePosterCarouselView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack {
                Text(title)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                NavigationLink {
                    ShowAllMoviesView()
                } label: {
                    Text("View All")
                        .lineLimit(1)
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) {movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            MoviePosterCard(movie: movie)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

