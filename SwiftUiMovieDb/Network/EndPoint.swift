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
    case discoverMovie
    case discoverTV
    case addFavoriteMovie
    case movieAccountStates(id: Int)
    
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
        case .discoverMovie:
            return "/discover/movie"
        case .discoverTV:
            return "/discover/tv"
        case .addFavoriteMovie:
            return "/account/14719795/favorite"
        case .movieAccountStates(let id):
            return "/movie/\(id)/account_states"
        }
    }
}
