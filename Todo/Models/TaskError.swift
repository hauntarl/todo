//
//  TaskError.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import Foundation

/**
 TaskError maps to all the error responses generated by the API.
 
 Refer [API Specification](https://github.com/hauntarl/todo-api/blob/main/Docs/API.md) for
 more details.
 */
struct TaskError: Decodable {
    let title: String
    let status: Int
}
