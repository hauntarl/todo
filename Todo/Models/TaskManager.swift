//
//  TaskManager.swift
//  Todo
//
//  Created by Sameer Mungole on 4/22/24.
//

import SwiftUI

/**
 TaskManager represents an aggregate model that is responsible for managing all task
 related operations like **fetching, creating, updating, and deleting** from the api.
 
 - Parameters:
    - items: Holds the list of `TaskItem` objects
    - errorMessage: Holds any error messages generated throughout the app
 
 Refer [Model View (MV)](https://forums.developer.apple.com/forums/thread/699003)
 architecture for more details.
 */
@MainActor
class TaskManager: ObservableObject {
    @Published var items: [TaskItem] = []
    @Published var errorMessage: String?
    
    private let service = NetworkService.shared
    
    /// Fetches the list of tasks from the service based on the provided
    /// filter and sort configuration.
    func fetchTasks(for config: Settings) async {
        let url = service.fetchTasksURL(
            filterBy: config.filterBy.description,
            sortBy: "\(config.orderBy.description)\(config.sortBy.description)"
        )
        await withErrorHandling {
            items = try await service.fetch(from: url)
        }
    }
    
    /// Fetches task details for the provided task id.
    func fetchTask(for id: TaskItem.ID) async {
        let url = service.fetchTaskURL(for: id)
        await withErrorHandling {
            let _: TaskItem = try await service.fetch(from: url)
        }
    }
    
    /// Creates a new task from the provided details.
    func create(task: NewTask) async {
        let url = service.createTaskURL()
        await withErrorHandling {
            let item: TaskItem = try await service.create(for: task, at: url)
            items.insert(item, at: 0)
        }
    }
    
    /// Updates an existing task with the edited task details.
    func edit(task: TaskItem) async {
        let url = service.updateTaskURL(for: task.id)
        await withErrorHandling {
            try await service.update(at: url, for: task)
            if let index = items.firstIndex(where: { $0.id == task.id }) {
                items[index] = task
            }
        }
    }
    
    /// Deletes a task associated to the provided id.
    func deleteTask(for id: TaskItem.ID) async {
        let url = service.deleteTaskURL(for: id)
        await withErrorHandling {
            try await service.delete(at: url)
        }
    }
    
    /// Executes an asynchronous action with error handling
    private func withErrorHandling(action: () async throws -> Void) async {
        do {
            try await action()
        } catch NetworkError.parsing(let message) {
            errorMessage = message
        } catch NetworkError.response(let message) {
            errorMessage = message
        } catch NetworkError.server(let error) {
            errorMessage = error.title
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
