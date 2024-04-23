//
//  TaskListView+Extension.swift
//  Todo
//
//  Created by Sameer Mungole on 4/22/24.
//

import SwiftUI

/**
 This extension deals with all the task list related operations
 */
extension TaskListView {
    var taskList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(manager.items, content: buildTaskDetails)
            }
            .animation(.bouncy(duration: 0.75), value: manager.items)
        }
        .scrollIndicators(.hidden)
    }
    
    func buildTaskDetails(for item: TaskItem) -> some View {
        let index = manager.items.firstIndex(of: item)!
        
        return Card(
            title: item.description,
            dueDate: item.dueAt ?? .defaultDate,
            createdDate: item.createdAt,
            isCompleted: $manager.items[index].completed,
            onEdit: { showEditView(for: item) },
            onDelete: { delete(task: item) }
        )
        .transition(
            .asymmetric(
                insertion: .scale.combined(with: .move(edge: .trailing)),
                removal: .scale.combined(with: .move(edge: .leading))
            )
        )
        .onChange(of: manager.items[index].completed) {
            update(task: manager.items[index])
        }
    }
    
    func showEditView(for task: TaskItem) {
        route.navigate(to: .editTask(item: task))
    }
    
    func update(task: TaskItem) {
        Task {
            await manager.edit(task: task)
        }
    }
    
    func delete(task: TaskItem) {
        manager.items.removeAll { $0.id == task.id }
        Task {
            await manager.deleteTask(for: task.id)
        }
    }
}
