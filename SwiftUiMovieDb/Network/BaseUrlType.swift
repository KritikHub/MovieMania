//
//  BaseUrlType.swift
//  SwiftUiMovieDb
//
//  Created by mac on 03/11/23.
//

import Foundation

enum BaseURLType {
    case movieDB
     
    var baseURLString: String {
        switch self {
        case .movieDB:
            return "https://api.themoviedb.org/3"
        }
    }
}
