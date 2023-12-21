//
//  favoriteMovieModel.swift
//  SwiftUiMovieDb
//
//  Created by mac on 12/12/23.
//

import Foundation

struct FavoriteMovie: Codable, Identifiable {
    var id: Int
    var name: String = ""
    var poster_path: String = ""
    
    var nameValue: String {
        return name
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path)")!
    }
}

struct FavoriteMovieResponse: Decodable {
    var success: Bool
    var status_code: Int
    var status_message: String
}

struct FavoriteMovieBodyData: Encodable {
    var media_type: String
    var media_id: Int
    var favorite: Bool
}
