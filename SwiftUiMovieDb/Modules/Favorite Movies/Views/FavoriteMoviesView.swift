//
//  FavoriteMoviesView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 19/12/23.
//

import SwiftUI

struct FavoriteMoviesView: View {
    
    @StateObject var viewModel = FavoriteMoviesViewModel()
    
    private var columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .loading:
                loaderView
            case .success(let data):
                mainContent(data: data)
                EmptyView()
            case .error:
                EmptyView()
            }
        }
        .onAppear {
            viewModel.getFavoriteMovies()
        }
    }
    
    private var loaderView: some View {
        Color.clear
            .showLoader(true, tint: .gray, background: .white)
    }
    
    private func mainContent(data: [FavoriteMovie]) -> some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(data) { object in
                    MovieCardView(name: object.nameValue, url: object.posterURL)
                }
            }
        }
    }
}

struct FavoriteMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesView()
    }
}
