//
//  DescriptiveErrorType.swift
//  SwiftUiMovieDb
//
//  Created by mac on 04/11/23.
//

import Foundation

struct MDBErrorConstants {
    static let DataNotInExpectedFormat = "Something fishy! Try later"
    static let UnknownError = "Unknown error"
    static let noInternetMessage = "Lure the Net! No Connectivity..."
    static let networkSessionNotFound = "Could not find a valid session"
    static let dataParsingFailed = "Sorry! Something went wrong.\n We couldn't parse the data. Please try in a while."
    static let invalidSelf = "Invalid Self"
    static let favoriteListFirebaseError = "Firebase error"
}

enum MDBError: DescriptiveErrorType {
    case dataNotInExpectedFormat
    case unknown
    case noInternet
    case apiError(String?)
    case customError(String?)
    case networkSessionNotFound
    case dataParsingError
    case invalidSelf
    case customErrorWithCode(String, Int)
    case firebaseError(NSError)
    case favoriteListFirebaseError
    
    var description: String {
        var errorDescription: String = MDBErrorConstants.UnknownError
        switch self {
        case .dataNotInExpectedFormat:
            errorDescription = MDBErrorConstants.DataNotInExpectedFormat
        case .unknown:
            errorDescription = MDBErrorConstants.UnknownError
        case .noInternet:
            errorDescription = MDBErrorConstants.noInternetMessage
        case .apiError(let customError):
            errorDescription = customError ?? "N/A"
        case .customError(let customError):
            errorDescription = customError ?? "N/A"
        case .networkSessionNotFound:
            errorDescription = MDBErrorConstants.networkSessionNotFound
        case .dataParsingError:
            errorDescription = MDBErrorConstants.dataParsingFailed
        case .invalidSelf:
            errorDescription = MDBErrorConstants.invalidSelf
        case .customErrorWithCode(let message,_):
            errorDescription = message
        case .firebaseError(let FirebaseError):
            errorDescription = filterFirebaseError(FirebaseError.localizedDescription)
        case .favoriteListFirebaseError:
            errorDescription = MDBErrorConstants.favoriteListFirebaseError
        }
        return errorDescription
    }
    
    fileprivate func filterFirebaseError(_ errorDescription: String) -> String {
        guard let index = errorDescription.firstIndex(of: ")") else {
            return errorDescription
        }
        
        return String(errorDescription[errorDescription.index(index, offsetBy: 2) ..< errorDescription.endIndex])
    }
}

protocol DescriptiveErrorType: Error, CustomStringConvertible {
    var title: String { get }
    var errorShortDescription: String { get }
    var errorCode: Int? {get}
}

extension DescriptiveErrorType {
    
    var title: String {
        get {
            return "Error"
        }
    }
    
    var errorShortDescription: String {
        get {
            return description
        }
    }
    
    var errorCode: Int? {
        return nil
    }
}
