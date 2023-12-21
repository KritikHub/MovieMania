//
//  ShowMovieCardView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 24/11/23.
//

import SwiftUI
import Kingfisher

struct MovieCardView: View {
    
    private let frameHeight: CGFloat = 180
    private let shadowRadius: CGFloat = 4
    private let cornerRadius: CGFloat = 8
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var movieCardWidth: CGFloat {
        (screenWidth - 2 * 16 - 16) / 2
    }
    
    private var movieCardPlaceholderImage: some View {
        Image("PosterImagePlaceholder")
            .resizable()
    }
    
    let name: String
    let url: URL
    
    var body: some View {
        VStack(alignment: .center) {
            movieImage
            Text(name)
                .lineLimit(1)
        }
    }
    
    private var movieImage: some View {
        KFImage(url)
            .placeholder { movieCardPlaceholderImage }
            .cacheMemoryOnly()
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: movieCardWidth, height: frameHeight)
            .shadow(radius: shadowRadius)
            .cornerRadius(cornerRadius)
    }
}
