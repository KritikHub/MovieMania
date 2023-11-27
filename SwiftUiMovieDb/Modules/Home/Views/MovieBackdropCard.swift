//
//  MovieBackdropCard.swift
//  SwiftUiMovieDb
//
//  Created by mac on 27/07/23.
//

import SwiftUI
import Kingfisher

struct MovieBackdropCard: View {
    
    let movie: Movie
    private let aspectRatio: CGFloat = 16/9
    private let cornerRadius: CGFloat = 8
    private let shadowRadius: CGFloat = 4
    private let lineLimit = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                KFImage(movie.backdropURL)
                    .placeholder(backdropPlaceholderImage)
                    .cacheMemoryOnly()
                    .resizable()
                    .aspectRatio(aspectRatio, contentMode: .fit)
            }
            .cornerRadius(cornerRadius)
            .shadow(radius: shadowRadius)
            Text(movie.title)
        }
        .lineLimit(lineLimit)
    }
}

func backdropPlaceholderImage() -> some View {
    Image("PosterImagePlaceholder")
        .resizable()
}

//struct MovieBackdropCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieBackdropCard(movie: Movie.stubbedMovie)
//    }
//}
