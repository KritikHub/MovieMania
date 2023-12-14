//
//  GenreView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 05/12/23.
//

import SwiftUI

struct GenreView: View {
    
    @StateObject var viewModel = GenreViewModel()
    @State var tabIndex = 0
    @State var genreType = GenreType.movies
    
    private let buttonWidth: CGFloat = 160
    private let buttonHeight: CGFloat = 50
    private let buttonCornerRadius: CGFloat = 8
    private let shadowCornerRadius: CGFloat = 8
    private let shadowXOffset: CGFloat = 0
    private let shadowYOffset: CGFloat = 5
    
    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .loading:
                loaderView
            case .success(let genres):
                mainContent(genreList: genres)
            case .error:
                EmptyView()
            }
        }
        .onAppear {
            viewModel.loadMovie(with: GenreType.movies)
        }
    }
    
    private var loaderView: some View {
        Color.clear
            .showLoader(true, tint: .gray, background: .white)
    }
    
    private func mainContent(genreList: [GenreItem]) -> some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    ButtonTab(type: GenreType.movies)
                    Spacer()
                    ButtonTab(type: GenreType.TvSeries)
                    Spacer()
                }
                List {
                    ForEach(genreList, id: \.id) { item in
                        NavigationLink(destination: DiscoverGenreView(genreType: genreType, genreId: item.id)) {
                            Text(item.name)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func ButtonTab(type: GenreType) -> some View {
        Button(action: {
            loadGenreType(type: type)
        }, label: {
            Text(type.title)
                .foregroundColor(.black)
                .frame(width: buttonWidth, height: buttonHeight)
                .background(type == genreType ? Color.gray : Color.white)
                .cornerRadius(buttonCornerRadius)
                .shadow(color: .gray, radius: shadowCornerRadius, x: shadowXOffset, y: shadowYOffset)
        })
    }
    
    private func loadGenreType(type: GenreType) {
        if type == GenreType.movies {
            genreType = type
            viewModel.loadMovie(with: genreType)
        } else {
            genreType = type
            viewModel.loadMovie(with: genreType)
        }
    }
}
