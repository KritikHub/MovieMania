//
//  TVListData.swift
//  SwiftUiMovieDb
//
//  Created by mac on 06/12/23.
//

import Foundation

struct TVListData: Decodable {
    let results: [TVSeries]
}

struct TVSeries: Decodable, Identifiable {
    let id: Int
    let name: String
    let backdrop_path: String?
    let overview: String
    let poster_path: String?
    let uniqueID: UUID = UUID()
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdrop_path ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path ?? "")")!
    }
    
}
