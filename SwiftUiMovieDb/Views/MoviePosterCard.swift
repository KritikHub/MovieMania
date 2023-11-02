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
    let cache = ImageCache.default
    var body: some View {
        ZStack {
            if cache.isCached(forKey: "my_cache_key") {
              
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
                Text(movie.title)
                .multilineTextAlignment(.center)
            } else {
                KFImage(movie.posterURL)
                    .cacheMemoryOnly()
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .cornerRadius(8)
                    .shadow(radius: 4)
            }
        }
        .frame(width: 204, height: 306)
    }
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: Movie.stubbedMovie)
    }
}
