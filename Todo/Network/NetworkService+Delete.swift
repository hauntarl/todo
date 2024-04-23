//
//  NetworkService+Delete.swift
//  Todo
//
//  Created by Sameer Mungole on 4/22/24.
//

import Foundation

extension NetworkService {
    /// Executes an HTTP DELETE request using the provided url
    func delete(at url: URL) async throws {
        // Create url request from the url
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.delete
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        // Execute request
        let (_, response) = try await execute(request: request)
        // Verify if the response for DELETE request is 204 (No Content)
        guard response.statusCode == StatusCode.noContent else {
            throw NetworkError.parsing(
                "Received `\(response.statusCode)` response, "
                + "but expected `204 (Created)`."
            )
        }
    }
    
    /// Builds url for deleting a task associated with the provided id
    func deleteTaskURL(for id: TaskItem.ID) -> URL {
        buildURL(for: "/tasks/\(id)", relativeTo: baseURL)
    }
}
