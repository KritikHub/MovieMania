//
//  ShowMovieCardView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 24/11/23.
//

import SwiftUI
import Kingfisher

struct ShowMovieCardView: View {
    
    var movie: Movie
    var body: some View {
        VStack(alignment: .center) {
            movieCard(movie: movie)
            Text(movie.title)
                .lineLimit(1)
        }
    }
}

func movieCard(movie: Movie) -> some View {
     let frameHeight: CGFloat = 180
     let shadowRadius: CGFloat = 4
     let cornerRadius: CGFloat = 8
    
    return KFImage(movie.posterURL)
        .placeholder(movieCardPlaceholderImage)
        .cacheMemoryOnly()
        .resizable()
        .scaledToFill()
        .frame(height: frameHeight)
        .shadow(radius: shadowRadius)
        .cornerRadius(cornerRadius)
}

func movieCardPlaceholderImage() -> some View {
    Image("PosterImagePlaceholder")
        .resizable()
}
