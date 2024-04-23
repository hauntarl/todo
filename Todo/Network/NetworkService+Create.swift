//
//  NetworkService+Create.swift
//  Todo
//
//  Created by Sameer Mungole on 4/22/24.
//

import Foundation

extension NetworkService {
    /// Executes an HTTP POST request using the provided url and request body
    func create<Request: Encodable, Result: Decodable>(
        for body: Request,
        at url: URL
    ) async throws -> Result {
        // Create url request from the url
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Try encoding request body
        guard let encoded = try? encoder.encode(body) else {
            throw NetworkError.parsing("Encoding error: `\(Request.self)`")
        }
        // Attach request body to the POST request
        request.httpBody = encoded

        // Execute request
        let (data, response) = try await execute(request: request)
        // Verify if the response for POST request is 201 (Created)
        guard response.statusCode == StatusCode.created else {
            throw NetworkError.response(
                "Received `\(response.statusCode)` response, "
                + "but expected `201 (Created)`."
            )
        }
        // Try decoding the data to provided `Result` type
        guard let decoded = try? decoder.decode(Result.self, from: data) else {
            throw NetworkError.parsing("Expected `\(Result.self)` type response.")
        }
        
        return decoded
    }
    
    /// Builds url for creating a new task
    func createTaskURL() -> URL {
        buildURL(for: "/tasks", relativeTo: baseURL)
    }
}
