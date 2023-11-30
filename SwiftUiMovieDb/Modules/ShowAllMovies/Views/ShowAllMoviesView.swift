//
//  ShowAllMoviesView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 24/11/23.
//

import SwiftUI

struct ShowAllMoviesView: View {
    
    @StateObject private var manager = ShowAllMoviesViewModel()
    @State var prevPageNo = 1
    
    var viewStates: ViewState<[Movie]> {
        return manager.viewState
    }
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var movieCardWidth: CGFloat {
        (screenWidth - 2 * 16 - 16) / 2
    }
    
    private var nextPageNo: Int {
        prevPageNo = prevPageNo + 1
        return prevPageNo
    }
    
    private var columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible())]
    
    private var allMovies: [Movie] {
        return manager.movies
    }
    
    private var loaderView: some View {
        Color.clear
            .showLoader(true, tint: .gray, background: .white)
    }

    var body: some View {
        mainContent
            .onAppear {
                manager.loadMovies(with: .now_playing, pageNo: 1, prevPageNo: prevPageNo)
            }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        ZStack{
            switch viewStates {
            case .loading:
                loaderView
            case .success(let data):
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(data) { movie in
                            ShowMovieCardView(movie: movie)
                                .onAppear {
                                    if manager.isLastItem(movieId: movie.id) {
                                        manager.loadMovies(with: .now_playing,
                                                           pageNo: nextPageNo,
                                                           prevPageNo: prevPageNo)
                                    }
                                }
                                .frame(width: movieCardWidth)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            case .error:
                EmptyView()
            }
        }
    }
}

struct ShowAllMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllMoviesView()
    }
}
