//
//  NetworkService+Fetch.swift
//  Todo
//
//  Created by Sameer Mungole on 4/22/24.
//

import Foundation

extension NetworkService {
    /// Executes an HTTP GET request using the provided url
    func fetch<Result: Decodable>(from url: URL) async throws -> Result {
        // Create url request from the url
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Execute request
        let (data, response) = try await execute(request: request)
        // Verify if the response for POST request is 200 (OK)
        guard response.statusCode == StatusCode.ok else {
            throw NetworkError.response(
                "Received `\(response.statusCode)` response, "
                + "but expected `200 (OK)`."
            )
        }
        // Try decoding the data to provided `Result` type
        guard let decoded = try? decoder.decode(Result.self, from: data) else {
            throw NetworkError.parsing("Expected `\(Result.self)` type response.")
        }
        
        return decoded
    }
    
    /// Builds url for fetching list of tasks
    func fetchTasksURL(filterBy: Bool, sortBy: String) -> URL {
        let params: [URLQueryItem] = [
            .init(name: "completed", value: String(filterBy)),
            .init(name: "sort_by", value: sortBy)
        ]
        return buildURL(
            for: "/tasks",
            relativeTo: baseURL,
            queryItems: params
        )
    }
    
    /// Builds url for fetching associated task for the provided id
    func fetchTaskURL(for id: TaskItem.ID) -> URL {
        buildURL(for: "/tasks/\(id)", relativeTo: baseURL)
    }
}
