//
//  GenreData.swift
//  SwiftUiMovieDb
//
//  Created by mac on 05/12/23.
//

import Foundation

struct GenreList: Decodable {
    let genres: [GenreItems]
}

struct GenreItems: Decodable, Identifiable {
    let id: Int
    let name: String
}
