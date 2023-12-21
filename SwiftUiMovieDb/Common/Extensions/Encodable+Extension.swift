//
//  Encodable+Extension.swift
//  SwiftUiMovieDb
//
//  Created by mac on 12/12/23.
//

import Foundation

extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
     }
}
