//
//  AccountStatesData.swift
//  SwiftUiMovieDb
//
//  Created by mac on 21/12/23.
//

import Foundation

struct MovieAcountStatesData: Decodable {
    let id: Int
    let favorite: Bool
    let rated: Bool
    let watchlist: Bool
}
