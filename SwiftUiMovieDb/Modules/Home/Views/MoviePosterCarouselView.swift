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
        VStack(alignment: .center, spacing: .zero) {
            HStack {
                Text(title)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                Text("View All")
                    .lineLimit(1)
                    .background(emptyNavigationLink(ShowAllMoviesView()))
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

extension View {
    func emptyNavigationLink<T: View>(_ destination: T) -> some View {
        NavigationLink(destination: destination) {}
    }
}

//struct MoviePosterCarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoviePosterCarouselView(title: "Now Playing", movies: nil)
//    }
//}
