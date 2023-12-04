//
//  MovieListView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 03/08/23.
//

import SwiftUI

struct MovieListView: View {
    
    @StateObject private var viewModel =  MovieListViewModel()
    
    func movies(for section: MoviesCategory,
                from moviesDict: [MoviesCategory : [Movie]]) -> [Movie] {
        let elementKey = moviesDict.keys.first { $0 == section }
        return moviesDict[elementKey ?? .now_playing] ?? []
    }
    
    var body: some View {
        NavigationView  {
            switch viewModel.viewState {
            case .loading:
                loaderView
            case .success(let _movies):
                    ScrollView {
                        ForEach(MoviesCategory.allCases, id: \.self) { category in
                            movieSection(for: category, with: movies(for: category, from: _movies))
                        }
                    }
                    .navigationBarTitle("Movies Mania")
                    .navigationBarTitleDisplayMode(.inline)
            case .error(let error):
                Text("Something went wrong! \(error.localizedDescription)")
            }
        }
        .onAppear {
            self.viewModel.loadAllMovies()
        }
    }
    
    private func movieSection(for sectionType: MoviesCategory, with movies: [Movie]) -> some View {
        Group {
            switch sectionType {
            case .now_playing:
                MoviePosterCarouselView(title: sectionType.title, movies: movies)
            default:
                MovieBackdropCarouselView(title: sectionType.title, movies: movies)
            }
        }
    }
        
    private var loaderView: some View {
        Color.clear
            .showLoader(true, tint: .gray, background: .white)
    }
}
struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
