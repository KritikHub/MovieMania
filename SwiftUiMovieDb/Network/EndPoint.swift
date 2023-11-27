//
//  EndPoint.swift
//  SwiftUiMovieDb
//
//  Created by mac on 03/11/23.
//

import Foundation

enum EndPoint {
    case nowPlaying
    case upcoming
    case topRated
    case popular
    case movieDetails(id: Int)
    
    var rawValue: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        case .upcoming:
            return "/movie/upcoming"
        case .topRated:
            return "/movie/top_rated"
        case .popular:
            return "/movie/popular"
        case .movieDetails(let id):
            return "/movie/\(id)"
        }
    }
}
