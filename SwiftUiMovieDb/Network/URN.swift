//
//  URN.swift
//  SwiftUiMovieDb
//
//  Created by mac on 03/11/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol URN {
    associatedtype Derived: Decodable
    var endPoint: EndPoint { get }
    var baseURLType: BaseURLType { get }
    var queryPath: String? { get }
    var method: HTTPMethod { get }
    var parameters: [String: String]? { get }
    var areParametersPercentEncoded: Bool { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var urlQueryItems: [URLQueryItem] { get }
}

extension URN {
    
    var queryPath: String? {
        return nil
    }
    
    var urlQueryItems: [URLQueryItem] {
        let keyValue = APIKey()
        var queryItems = [URLQueryItem(name: "api_key", value: keyValue.apiKey)]
        if let parameters = parameters {
            for eachQueryParam in parameters {
                queryItems.append(URLQueryItem(name: eachQueryParam.key, value: eachQueryParam.value))
            }
        }
        return queryItems
    }
    
    var areParametersPercentEncoded: Bool {
        return false
    }
}

protocol MovieDBURN: URN {}

extension MovieDBURN {
    
    var baseURLType: String {
        let baseUrl = BaseURLType()
        return baseUrl.baseURLString
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var body: Data? {
        return nil
    }
    
    var headers: [String : String]? {
        switch method {
        case .get:
            return nil
        case .post, .put, .delete, .patch:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        }
    }
    
    var parameters: [String: String]? {
        return nil
    }
}
