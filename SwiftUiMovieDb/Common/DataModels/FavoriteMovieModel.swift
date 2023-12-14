//
//  favoriteMovieModel.swift
//  SwiftUiMovieDb
//
//  Created by mac on 12/12/23.
//

import Foundation

struct FavoriteMovie: Encodable {
    var name: String = ""
    var backdropPath: String = ""
}

struct FavoriteMovieResponse: Decodable {
    let success: String
    let status_code: Int
    let status_message: String
}

struct FavoriteMovieBodyData: Encodable {
    var media_type: String
    var media_id: Int
    var favorite: Bool
}
