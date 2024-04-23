//
//  NetworkService.swift
//  Todo
//
//  Created by Sameer Mungole on 4/22/24.
//

import Foundation

/// A generic network manager responsible for providing CRUD services
struct NetworkService {
    static let shared = Self()
    
    var session: URLSession = .shared
    var baseURL: URL = .init(string: "https://localhost:7104")!
    var encoder: JSONEncoder = .init()
    var decoder: JSONDecoder = .init()
    
    /// Executes provided request, performs verification against errors, returns response
    /// data and associated meta data.
    func execute(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await session.data(for: request)
        
        // Check if the response is an HTTPURLResponse
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.response(
                String(data: data, encoding: .utf8) ?? "Unexpected error occurred."
            )
        }
        
        // Check if its an error response using the pattern matching operator
        if StatusCode.errors ~= response.statusCode {
            // Try decoding the error response to `TaskError`
            guard let error = try? decoder.decode(TaskError.self, from: data) else {
                throw NetworkError.parsing(
                    "Expected `TaskError` for `\(response.statusCode)` response."
                )
            }
            // Throw `TaskError`
            throw NetworkError.server(error)
        }
        
        return (data, response)
    }
    
    /// Utility method that builds a URL from given path and query parameters
    func buildURL(
        for path: String,
        relativeTo baseURL: URL,
        queryItems: [URLQueryItem] = []
    ) -> URL {
        var url = path.isEmpty
        ? baseURL
        : baseURL.appendingPathComponent(path, conformingTo: .url)
        url.append(queryItems: queryItems)
        return url
    }
    
    /// HTTP request methods
    struct RequestMethod {
        static let get = "GET"
        static let post = "POST"
        static let put = "PUT"
        static let delete = "DELETE"
    }

    /// HTTP response codes
    struct StatusCode {
        static let ok = 200
        static let created = 201
        static let noContent = 204
        static let errors = 400...500
    }
}


/// NetworkError enum used for throwing specific network errors.
enum NetworkError: Error {
    case parsing(String)
    case response(String)
    case server(TaskError)
}
