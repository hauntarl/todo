//
//  NetworkService+Update.swift
//  Todo
//
//  Created by Sameer Mungole on 4/22/24.
//

import Foundation

extension NetworkService {
    /// Executes an HTTP PUT request using the provided url
    func update<Request: Encodable>(at url: URL, for body: Request) async throws {
        // Create url request from the url
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.put
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Try encoding request body
        guard let encoded = try? encoder.encode(body) else {
            throw NetworkError.parsing("Encoding failed for `\(Request.self)`.")
        }
        // Attach request body to the PUT request
        request.httpBody = encoded

        // Execute request
        let (_, response) = try await execute(request: request)
        // Verify if the response for PUT request is 204 (No Content) or 201 (Created)
        guard
            response.statusCode == StatusCode.noContent
            || response.statusCode == StatusCode.created
        else {
            throw NetworkError.response(
                "Received `\(response.statusCode)` response, "
                + "but expected `204 (No Content)` or `201 (Created)`."
            )
        }
    }
    
    /// Builds url for updating a task associated with the provided id
    func updateTaskURL(for id: TaskItem.ID) -> URL {
        buildURL(for: "/tasks/\(id)", relativeTo: baseURL)
    }
}
