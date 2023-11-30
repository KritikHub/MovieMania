//
//  ViewState.swift
//  SwiftUiMovieDb
//
//  Created by mac on 30/11/23.
//

import Foundation

enum ViewState<T: Decodable> {
    case loading
    case success(data: T)
    case error(MDBError)
    //case movieType(type: String)
}

