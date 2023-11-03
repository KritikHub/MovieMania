//
//  MoviePosterCard.swift
//  SwiftUiMovieDb
//
//  Created by mac on 03/08/23.
//

import SwiftUI
import Kingfisher

struct MoviePosterCard: View {
    
    let movie: Movie
    private let imageCornerRadius: CGFloat = 8
    private let imageShadowRadius: CGFloat = 4
    private let frameWidth: CGFloat = 204
    private let frameHeight: CGFloat = 306
    
    var body: some View {
        ZStack {
                KFImage(movie.posterURL)
                    .placeholder(posterPlaceholderImage)
                    .cacheMemoryOnly()
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .cornerRadius(imageCornerRadius)
                    .shadow(radius: imageShadowRadius)            
        }
        .frame(width: frameWidth, height: frameHeight)
    }
}

@ViewBuilder
private func posterPlaceholderImage() -> some View {
    Image("PosterImagePlaceholder")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 204, height: 306, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: Movie.stubbedMovie)
    }
}
