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
 
 The description for each enum is a convenience wrapper used for calculating query
 parameters for fetch tasks api.
 
 Refer [API Specification](https://github.com/hauntarl/todo-api/blob/main/Docs/API.md) for
 more details.
 */
class Settings: ObservableObject {
    @Published var filter: FilterBy = .all
    @Published var sortBy: SortBy = .created
    @Published var orderBy: OrderBy = .descending
    
    enum FilterBy: String, CaseIterable {
        case all = "All"
        case complete = "Complete"
        case incomplete = "Incomplete"
        
        var description: Bool {
            self == .complete
        }
    }
    
    enum SortBy: String, CaseIterable {
        case due = "Due"
        case created = "Created"
        
        var description: String {
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
        
        var description: String {
            self == .descending ? "-" : ""
        }
    }
}
