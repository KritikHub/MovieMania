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
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                KFImage(movie.backdropURL)                    
                    .cacheMemoryOnly()
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)                   
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            Text(movie.title)
        }
        .lineLimit(1)
    }
}

struct MovieBackdropCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCard(movie: Movie.stubbedMovie)
    }
}
