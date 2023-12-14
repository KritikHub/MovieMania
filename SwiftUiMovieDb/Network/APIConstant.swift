//
//  APIConstant.swift
//  SwiftUiMovieDb
//
//  Created by mac on 24/11/23.
//

import Foundation

enum Parameter: String {
    case movieDetails = "append_to_response"
    case page = "page"
    case query = "query"
    case with_genres = "with_genres"
}

enum Body: String {
    case mediaType = "media_type"
    case mediaId = "media_id"
    case favorite = "favorite"
}
