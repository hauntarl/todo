//
//  Settings.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import Foundation

/**
 Settings model provides data for the `SettingsView`.
 
 - Parameters:
    - filter: Enum to determine filter for tasks based on its `completed` status
    - sortBy: Enum to determine the sort key for tasks
    - orderBy: Enum to determine the order of tasks
 
 The raw values for each enum is a convenience wrapper used for calculating query parameters for fetch tasks api, refer
 [API Specification](https://github.com/hauntarl/todo-api/blob/main/Docs/API.md) for more details.
 */
struct Settings {
    var filter: Filter = .all
    var sortBy: SortBy = .created
    var orderBy: OrderBy = .descending
    
    enum Filter: String, CaseIterable {
        case all = "All"
        case complete = "Complete"
        case incomplete = "Incomplete"
        
        var rawValue: Bool {
            self == .complete
        }
    }
    
    enum SortBy: String, CaseIterable {
        case due = "Due"
        case created = "Created"
        
        var rawValue: String {
            switch self {
            case .due:
                "dueDate"
            case .created:
                "createdDate"
            }
        }
    }
    
    enum OrderBy: String, CaseIterable {
        case ascending = "Ascending"
        case descending = "Descending"
        
        var rawValue: String {
            self == .descending ? "-" : ""
        }
    }
}
