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
    
    func addFavoriteMovie(id: Int, movieName: String, posterPath: String) {
        var generateObject = FavoriteMovie(id: id)
        generateObject.id = id
        generateObject.name = movieName
        generateObject.poster_path = "\(posterPath)"
        
        ref.child("FavoriteMovie").child("\(id)").setValue(generateObject.toDictionary)
    }
    
    func removeFavoriteMovie(id: Int) {
        ref.child("FavoriteMovie").child("\(id)").removeValue()
    }
    
    func getFavoriteList(completion: @escaping (Result<[FavoriteMovie], MDBError>) ->  Void) {
        ref.child("FavoriteMovie").observeSingleEvent(of: .value) { parentSnapshot in
            guard let children = parentSnapshot.children.allObjects as? [DataSnapshot] else {
                completion(.failure(.firebaseError))
                return
            }
            let favoriteMovies: [FavoriteMovie] = children.compactMap({ snapshot in
                do {
                    return try snapshot.data(as: FavoriteMovie.self)
                } catch {
                    return nil
                }
            })
            completion(.success(favoriteMovies))
        }
    }
}
