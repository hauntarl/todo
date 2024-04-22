//
//  TaskItem.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import Foundation

/**
 TaskItem maps to the API request/response models for the **Fetch Task(s)** and **Update Task** operations,
 refer [API Specification](https://github.com/hauntarl/todo-api/blob/main/Docs/API.md) for more details.
 */
struct TaskItem: Codable, Identifiable {
    var id: String
    var description: String
    var createdAt: Date
    var dueAt: Date?
    var completed: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case description = "taskDescription"
        case createdAt = "createdDate"
        case dueAt = "dueDate"
        case completed
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.description = try container.decode(String.self, forKey: .description)
        
        // Parse the createdDate string into Swift Date object
        let createdDate = try container.decode(String.self, forKey: .createdAt)
        self.createdAt = Date.from(createdDate) ?? Date(timeIntervalSince1970: .zero)
        
        // Parse the dueDate string into Swift Date object
        let dueDate = try container.decode(String.self, forKey: .dueAt)
        self.dueAt = Date.from(dueDate) ?? .defaultDate
        
        self.completed = try container.decode(Bool.self, forKey: .completed)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.createdAt.iso8601, forKey: .createdAt)
        try container.encode((self.dueAt ?? .defaultDate).iso8601, forKey: .dueAt)
        try container.encode(self.completed, forKey: .completed)
    }
}
