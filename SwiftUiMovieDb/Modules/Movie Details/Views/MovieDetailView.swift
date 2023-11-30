//
//  MovieDetailView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 07/08/23.
//

import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    
    let movieId: Int
    @StateObject private var manager = MovieDetailsViewModel()
    
    var body: some View {
        ZStack {
            switch manager.viewState {
            case .loading:
                loaderView
            case .success(let movieDetails):
                MovieDetailListView(movie: movieDetails)
            case .error:
                EmptyView()
            }
        }
        .navigationTitle("manager.movieDetails.title")
        .onAppear {
            self.manager.loadMovie(with: self.movieId)
        }
    }
    
    private var loaderView: some View {
        Color.clear
            .showLoader(true, tint: .gray, background: .white)
    }
}
struct MovieDetailListView: View {
    
    let movie: MovieDetails
    @State private var selectedTrailer: MovieVideo?
    
    var body: some View {
        List {
            MovieDetailImage(imageURL: self.movie.backdropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            HStack {
                Text(movie.genreText)
                Text(".")
                Text(movie.yearText)
                Text(movie.durationText)
            }
            Text(movie.overview)
            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText).foregroundColor(.yellow)
                        .font(.system(size: 40))
                        .baselineOffset(30)
                    
                }
                Text(movie.scoreText)
                    .font(.headline)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        dimension[.trailing]
                    })
            }
            HStack(alignment: .top, spacing: 4) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Starring*").font(.headline)
                    ForEach(self.movie.cast!.prefix(9)) { cast in
                        Text(cast.name)
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Spacer()
                if movie.crew != nil && movie.crew!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        if movie.directors != nil &&
                            movie.directors!.count > 0{
                            Text("Directors").font(.headline)
                            ForEach(self.movie.directors!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                        if movie.producers != nil &&
                            movie.producers!.count > 0{
                            Text("Producers").font(.headline)
                                .fontWeight(.bold)
                                .padding(.top)
                            ForEach(self.movie.producers!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                        if movie.screenWriters != nil &&
                            movie.screenWriters!.count > 0{
                            Text("Screen Writers").font(.headline)
                                .fontWeight(.bold)
                                .padding(.top)
                            ForEach(self.movie.screenWriters!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
            Divider()
            if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0 {
                Text("Trailers").font(.headline)
                
                ForEach(movie.youtubeTrailers!) { trailer in
                    Button(action: {
                        self.selectedTrailer = trailer
                    }) {
                        HStack {
                            Text(trailer.name)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color(UIColor.systemBlue))
                        }
                    }
                }
            }
        }
        .sheet(item: self.$selectedTrailer) { trailer in
            SafariView(url: trailer.youtubeURL!)
            
        }
    }
}

struct MovieDetailImage: View {
    
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))           
            KFImage(imageURL)
                .placeholder(backdropPlaceholderImage)
                .cacheMemoryOnly()
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        MovieDetailView(movieId: Movies.stubbedMovie.id)
        }
    }
}
