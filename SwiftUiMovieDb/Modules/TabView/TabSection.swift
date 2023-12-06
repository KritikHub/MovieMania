//
//  TabTag.swift
//  SwiftUiMovieDb
//
//  Created by mac on 04/12/23.
//

import Foundation

enum TabViewSection {
    case home
    case search
    case genre
    
    var tag: Int {
        switch self {
        case .home:
            return 0
        case .search:
            return 1
        case .genre:
            return  2
        }
    }
}
