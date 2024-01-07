//
//  SignUpViewModel.swift
//  SwiftUiMovieDb
//
//  Created by mac on 01/01/24.
//

import Foundation
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    
    @Published var userData: User?
    @Published var error: DescriptiveErrorType?
    private let firebaseClient = FirebaseClient()
    
    func signUp(_ signUpData: SignUpData) {
        guard let email = signUpData.email else {
            return
        }
        guard let password = signUpData.password else {
            return
        }
        FirebaseClient.createUserWithEmail(email: email, password: password) { (result, error) in
            if let userError = error {
                self.error = userError
            }
            guard let user = result else {
                return
            }
            self.userData = user
            var provider = ""
            if let providerData = user.providerData.first {
                provider = providerData.providerID
            }
            let userDict = [
                FirebaseConstants.User.email: signUpData.email ?? "",
                FirebaseConstants.User.name: signUpData.name ?? "",
                FirebaseConstants.User.provider: provider
            ]
            self.saveAuthDataFor(user, signupData: userDict)
        }
    }
    
    fileprivate func saveAuthDataFor(_ user: User, signupData: [String: String]) {
        FirebaseClient.saveUserAuthData(user, userData: signupData, completion: { (error, ref) -> Void in
            if let _error = error {
                print("AUTH DTA ERROR %%%%%  ", _error)
                self.error = _error
            }
            FirebaseClient.fetchUserData({ (userData) in
            })
            //success(true, signupData)
        })
    }
}
