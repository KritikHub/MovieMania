//
//  DiscoverGenreView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 06/12/23.
//

import SwiftUI

struct DiscoverGenreView: View {
    
    @StateObject var viewModel = DiscoverGenreViewModel()
    @State var prevPageNo = 1
    private let genreId: Int
    private let genreType: GenreType
    
    init(genreType: GenreType, genreId: Int) {
        self.genreId = genreId
        self.genreType = genreType
        
    }
    private var columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible())]
    
    private var nextPageNo: Int {
        prevPageNo = prevPageNo + 1
        return prevPageNo
    }
    
    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .loading:
                loaderView
            case .success(let data):
                mainContent(data: data)
            case .error:
                EmptyView()
            }
        }
        .onAppear {
            viewModel.loadMovies(with: genreType, genreId: genreId, nextPageNo: prevPageNo)
        }
    }
    
    private var loaderView: some View {
        Color.clear
            .showLoader(true, tint: .gray, background: .white)
    }
    
    private func mainContent(data: [Movie]) -> some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(data, id: \.id) { item in
                        NavigationLink(destination: MovieDetailView(movieId: item.id)) {
                            MovieCardView(name: item.nameValue, url: item.posterURL)
                                .onAppear {
                                    handleLoadMore(item)
                                }
                        }
                    }
                }
            }
        }
    }
    
    private func handleLoadMore(_ movie: Movie) {
        if viewModel.isLastItem(movieId: movie.id) {
            self.viewModel.loadMovies(
                with: genreType,
                genreId: genreId,
                nextPageNo: nextPageNo
            )
        }
    }
}

