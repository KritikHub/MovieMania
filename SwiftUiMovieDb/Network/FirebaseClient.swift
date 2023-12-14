//
//  FirebaseClient.swift
//  SwiftUiMovieDb
//
//  Created by mac on 08/12/23.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

struct FirebaseClient {
    
    private let ref = Database.database().reference()
    
    func addFavoriteMovie(id: Int, movieName: String, backdropURL: URL) {
        var generateObject = FavoriteMovie()
        generateObject.name = movieName
        generateObject.backdropPath = "\(backdropURL)"
        
        ref.child("FavoriteMovie").child("\(id)").setValue(generateObject.toDictionary)
    }
    
    func removeFavoriteMovie(id: Int) {
        ref.child("FavoriteMovie").child("\(id)").removeValue()
    }
}
