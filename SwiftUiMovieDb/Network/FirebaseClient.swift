//
//  FirebaseClient.swift
//  SwiftUiMovieDb
//
//  Created by mac on 08/12/23.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseAuth

let ref = Database.database().reference()
var userData: FirebaseDictionary?
let keychainManager = KeychainManager()

struct FirebaseClient {
    
    static var currentUser = Auth.auth().currentUser
    
    
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
                completion(.failure(.favoriteListFirebaseError))
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
    
    static func createUserWithEmail(email: String, password: String, completion: @escaping (_ user: User?, _ error: DescriptiveErrorType?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let _error = error {
                print("ERROR ***** ", _error.localizedDescription)
                completion(nil, MDBError.firebaseError(_error as NSError))
                return
            }
            guard let user = result?.user else {
                completion(nil, nil)
                return
            }
            currentUser = user
            keychainManager.saveDataToKeychain(password, service: "firebase auth", account: email)
            completion(user, nil)
        }
    }
    
    static func signInUserWithEmail(email: String, password: String, completion: @escaping (_ user: User?, _ error: DescriptiveErrorType?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let _error = error {
                completion(nil, MDBError.firebaseError(_error as Error as NSError))
                return
            }
            guard let user = result?.user else {
                completion(nil, nil)
                return
            }
            currentUser = user
            completion(user, nil)
        }
    }
    
    static func saveUserAuthData(_ user: User, userData: [String: String], completion: @escaping (_ error: DescriptiveErrorType?, _ ref: DatabaseReference?) -> Void) {
        ref.child(FirebaseConstants.Entity.user).child(user.uid).updateChildValues(userData) { (error, ref) -> Void in
            if let _error = error {
                completion(MDBError.firebaseError(_error as NSError), nil)
                return
            }
            FirebaseClient.fetchUserData({ (userData) -> Void in
                
            })
            completion(nil, ref)
        }
    }
    
    static func fetchUserData(_ completion: @escaping (FirebaseDictionary?) -> Void) {
        if let user = currentUser {
            ref.child(FirebaseConstants.Entity.user).child(user.uid).observeSingleEvent(of: .value, with: {(snapshot) -> Void in
                userData = snapshot.value as? FirebaseDictionary
                completion(userData)
            })
        }
    }
}
