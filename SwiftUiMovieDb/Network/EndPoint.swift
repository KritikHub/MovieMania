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
    case searchMovie
    case movieGenre
    case tvSeriesGenre
    
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
        case .searchMovie:
            return "/search/movie"
        case .movieGenre:
            return "/genre/movie/list"
        case .tvSeriesGenre:
            return "/genre/tv/list"
        }
    }
}
