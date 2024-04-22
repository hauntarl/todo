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
                ForEach(items, content: buildTaskDetails)
            }
        }
        .scrollIndicators(.hidden)
    }
    
    func buildTaskDetails(for item: TaskItem) -> some View {
        let index = items.firstIndex { $0.id == item.id }!
        
        return Card(
            title: item.description,
            dueDate: item.dueAt ?? .defaultDate,
            createdDate: item.createdAt,
            isCompleted: $items[index].completed,
            onEdit: { edit(task: item) },
            onDelete: { deleteTask(at: index) }
        )
        .transition(.scale.combined(with: .move(edge: .leading)))
        .onChange(of: items[index].completed) {
            update(task: items[index])
        }
    }
    
    func edit(task: TaskItem) {
        route.navigate(to: .editTask(item: task))
    }
    
    func update(task: TaskItem) {
        // TODO: Update task completion status
    }
    
    func deleteTask(at index: Int) {
        withAnimation(.bouncy(duration: 0.75)) {
            _ = items.remove(at: index)
        }
        // TODO: Remove task
    }
}
