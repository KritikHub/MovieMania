//
//  TabView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 04/12/23.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedTabIndex: Int = 0
    private let moviesString = "Movies"
    private let searchString = "Search"
    private let genreString = "Genre"
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            MovieListView()
                .tabItem {
                    TabItemView(systemName: SystemImage.tv.rawValue, text: moviesString)
                }
                .tag(0)
            SearchMovieView()
                .tabItem {
                    TabItemView(systemName: SystemImage.search.rawValue, text: searchString)
                }
                .tag(1)
            GenreView()
                .tabItem {
                    TabItemView(systemName: SystemImage.genre.rawValue, text: genreString)
                }
        }
        
    }
}

struct TabItemView: View {

    private let systemName: String
    private let text: String

    init(systemName: String, text: String) {
        self.systemName = systemName
        self.text = text
    }

    var body: some View {
        VStack {
            Image(systemName: self.systemName)
                .renderingMode(.template)                
            Text(self.text)
        }
    }
}

