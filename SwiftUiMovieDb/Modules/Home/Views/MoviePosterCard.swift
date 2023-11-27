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

private func posterPlaceholderImage() -> some View {
    let imageFrameWidth: CGFloat = 204
    let imageFrameHeight: CGFloat = 306
    return Image("PosterImagePlaceholder")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: imageFrameWidth, height: imageFrameHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
}
