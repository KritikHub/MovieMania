//
//  TVSeriesData.swift
//  SwiftUiMovieDb
//
//  Created by mac on 07/12/23.
//

import Foundation

struct TVSeriesData: Decodable {
    
    let id: Int
    let name: String
    let backdrop_path: String
    let genres: [TVSeriesGenre]
    let number_of_episodes: Int
    let number_of_seasons: Int
    let overview: String
    let poster_path: String
    let seasons: [SeasonModel]
    
}

struct TVSeriesGenre: Decodable {
    
    let id: Int
    let name: String
}

struct SeasonModel: Decodable {
    
    let id: Int
    let name: String
    let poster_path: String
    let episode_count: Int
}
