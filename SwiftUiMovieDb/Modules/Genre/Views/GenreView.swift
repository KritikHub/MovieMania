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
    
    private func mainContent(genreList: [GenreItems]) -> some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    ButtonTab(index: 0, title: GenreType.movies.title)
                    Spacer()
                    ButtonTab(index: 1, title: GenreType.TvSeries.title)
                    Spacer()
                }
                List {
                    ForEach(genreList, id: \.id) { item in
                        NavigationLink(destination: ShowAllMoviesView()) {
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
    
    private func ButtonTab(index: Int, title: String) -> some View {
        Button(action: {
            changeIndex(index: index)
            loadGenreType(index: index)
        }, label: {
            Text(title)
                .foregroundColor(.black)
                .frame(width: buttonWidth, height: buttonHeight)
                .background(index == tabIndex ? Color.gray : Color.white)
                .cornerRadius(buttonCornerRadius)
                .shadow(color: .gray, radius: shadowCornerRadius, x: shadowXOffset, y: shadowYOffset)
        })
    }
    
    private func loadGenreType(index: Int) {
        if index == 0 {
            viewModel.loadMovie(with: GenreType.movies)
        } else {
            viewModel.loadMovie(with: GenreType.TvSeries)
        }
    }
    
    private func changeIndex(index: Int) {
        if index != tabIndex {
            tabIndex = index
        }
    }
}

struct GenreView_Previews: PreviewProvider {
    static var previews: some View {
        GenreView()
    }
}
