//
//  MovieStore.swift
//  SwiftUiMovieDb
//
//  Created by mac on 26/07/23.
//

import Foundation

class MovieStore: MovieService {
  
    
    static let shared = MovieStore()
    private init() {}
    
    private let apiKey = "3492e734e03e243d1f8b59388a7b1bb2"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movies, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: ["append_to_response": "videos,credits"], completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "language": "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ], completion: completion)
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalUrl = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: finalUrl) {[weak self] (data, response, error) in
            guard let self = self else {
                return
            }
            if error != nil {
                self.executeCompletionHandlerInMainTread(with: .failure(.apiError), completion: completion)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainTread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            guard let data = data else {
                self.executeCompletionHandlerInMainTread(with: .failure(.noData), completion: completion)
                return
            }
            do {
                let decodedResponse =  try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainTread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainTread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
        
    }
        
        private func executeCompletionHandlerInMainTread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
            DispatchQueue.main.async {
                completion(result)
            }
        }
    
}
