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
    @StateObject private var viewModel = MovieDetailsViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .loading:
                loaderView
            case .success(let movieDetails):
                MovieDetailListView(movie: movieDetails, viewModel: viewModel)
            case .error:
                EmptyView()
            }
        }
        .navigationTitle("Details")
        .onAppear {
            self.viewModel.loadMovie(with: self.movieId)
        }
    }
    
    private var loaderView: some View {
        Color.clear
            .showLoader(true, tint: .gray, background: .white)
    }
}
struct MovieDetailListView: View {
    
    let movie: MovieDetails
    let viewModel: MovieDetailsViewModel
    @State private var selectedTrailer: MovieVideo?
    
    var body: some View {
        List {
            MovieDetailImage(movie: movie, viewModel: viewModel)
            HStack {
                Text(movie.genreText)
                Text(".")
                Text(movie.yearText)
                Text(movie.durationText)
            }
            Text(movie.overview)
            ratingViewContent
            castDetailsContent
            Divider()
            if isYoutubeTrailerAvailable(movie: movie) {
                Text("Trailers")
                    .font(.headline)
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
    
    private var ratingViewContent: some View {
        HStack {
            if !isRatingAvailable(movie: movie) {
                Text(movie.ratingText).foregroundColor(.yellow)
                    .font(.system(size: 10))
            }
            Text(movie.scoreText)
                .font(.headline)
                .alignmentGuide(.leading, computeValue: { dimension in
                    dimension[.trailing]
                })
        }
    }
    
    private var castDetailsContent: some View {
        HStack(alignment: .top, spacing: 4) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Starring*")
                    .font(.headline)
                ForEach(self.movie.cast!.prefix(9)) { cast in
                    Text(cast.name)
                }
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
            if isCrewDetailsAvailable(movie: movie) {
                VStack(alignment: .leading, spacing: 4) {
                    if isDirectorsDetailsAvailable(movie: movie){
                        Text("Directors")
                            .font(.headline)
                        ForEach(self.movie.directors!.prefix(2)) { crew in
                            Text(crew.name)
                        }
                    }
                    if isProducersDetailsAvailable(movie: movie) {
                        Text("Producers")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top)
                        ForEach(self.movie.producers!.prefix(2)) { crew in
                            Text(crew.name)
                        }
                    }
                    if isScreenWritersDetailsAvailable(movie: movie) {
                        Text("Screen Writers")
                            .font(.headline)
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
    }
}

struct MovieDetailImage: View {
    
    let movie: MovieDetails
    let viewModel: MovieDetailsViewModel
    let firebaseClient = FirebaseClient()
    @State var isFavorite = false
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))           
            KFImage(movie.backdropURL)
                .placeholder(backdropPlaceholderImage)
                .cacheMemoryOnly()
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(
                    Image(systemName: isFavorite ? "suit.heart.fill" : "heart")
                        .padding()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topTrailing)
                        .foregroundColor(.red)
                        .onTapGesture {
                            isFavorite.toggle()
                            if isFavorite == true {
                                firebaseClient.addFavoriteMovie(id: movie.id,
                                                                movieName: movie.title,
                                                                backdropURL: movie.backdropURL)
                                viewModel.addFavoriteMovie(id: movie.id, isAddToFavorite: true)
                            } else {
                                firebaseClient.removeFavoriteMovie(id: movie.id)
                                viewModel.addFavoriteMovie(id: movie.id, isAddToFavorite: false)
                            }
                        }
                )
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
