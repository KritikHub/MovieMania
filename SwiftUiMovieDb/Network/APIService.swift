//
//  APIService.swift
//  SwiftUiMovieDb
//
//  Created by mac on 04/11/23.
//

import Foundation

class APIService {
    
    func makeRequest<T: URN>(with urnData: T,
                             completionHandler: @escaping (Result<T.Derived, MDBError>) -> Void) {
    
        var urlComponents = URLComponents(string: urnData.baseURLType.baseURLString +
                                            urnData.endPoint.rawValue)!
        
        if urnData.areParametersPercentEncoded {
            urlComponents.percentEncodedQueryItems = urnData.urlQueryItems
        } else {
            urlComponents.queryItems = urnData.urlQueryItems
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = urnData.method.rawValue
        request.allHTTPHeaderFields = urnData.headers
        request.httpBody = urnData.body
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            
            guard let _self = self else {
                completionHandler(.failure(.invalidSelf))
                return
            }
            
            if let error = error {
                if error._code == NSURLErrorNotConnectedToInternet {
                    completionHandler(.failure(.noInternet))
                } else {
                    completionHandler(.failure(.customError(error.localizedDescription)))
                }
                return
            }
            
            guard let _data = data, let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.unknown))
                return
            }
            
            let statusCode = httpResponse.statusCode
            let headers = httpResponse.allHeaderFields as? [String: String]
            if statusCode == 200 {
                _self.process(responseData: _data,
                              responseHeaders: headers,
                              completion: completionHandler)
            } else {
                if let _error = _self.movieDBError(statusCode, responseData: _data) {
                    completionHandler(.failure(_error))
                }else {
                    guard let _error = error else {
                        completionHandler(.failure(.unknown))
                        return
                    }
                    completionHandler(.failure(MDBError.customError(_error.localizedDescription)))
                }
            }
    }
    task.resume()
}

private func process<T: Decodable>(responseData: Data,
                                   responseHeaders: [String: String]?,
                                   completion: @escaping(Result<T, MDBError>)->()) {
    if let derivedModel = CodableMapper<T>.convert(responseData: responseData) {
        completion(.success(derivedModel))
    } else {
        completion(.failure(.dataParsingError))
    }
}

private func movieDBError(_ statusCode: Int, responseData: Data) -> MDBError? {
    if let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: []) as? NSDictionary,
        let errorMessage = jsonData.value(forKey: "message") as? String {
        if let errorCode = jsonData.value(forKey: "errorCode") as? Int {
            return .customErrorWithCode(errorMessage, errorCode)
        }
        return .customError(errorMessage)
    } else {
        return nil
    }
}
}
