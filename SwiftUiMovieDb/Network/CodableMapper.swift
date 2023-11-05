//
//  CodableMapper.swift
//  SwiftUiMovieDb
//
//  Created by mac on 05/11/23.
//

import Foundation

struct CodableMapper<T: Decodable> {
    
    static func convert(responseData: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: responseData)
        } catch {
            assertionFailure("Unknown server response")
            return nil
        }
    }
}
