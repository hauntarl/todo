//
//  NewTask.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import Foundation

/**
 NewTask maps to the API request model for the **Create Task** operations, refer
 [API Specification](https://github.com/hauntarl/todo-api/blob/main/Docs/API.md) for more details.
 */
struct NewTask: Encodable {
    var description: String = ""
    var dueAt: Date?
    var completed: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case description = "taskDescription"
        case dueAt = "dueDate"
        case completed
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.description, forKey: .description)
        try container.encode((self.dueAt ?? .defaultDate).iso8601, forKey: .dueAt)
        try container.encode(self.completed, forKey: .completed)
    }
}
