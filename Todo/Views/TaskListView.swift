//
//  TaskListView.swift
//  Todo
//
//  Created by Sameer Mungole on 4/22/24.
//

import SwiftUI

/**
 TaskListView displays the provided task items in a vertical scroll view
 
 - Parameters:
    - items: List of task items to display
 */
struct TaskListView: View {
    @Binding var items: [TaskItem]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(items, content: buildTaskDetails)
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
    }
    
    private func buildTaskDetails(for item: TaskItem) -> some View {
        let index = items.firstIndex { $0.id == item.id }!
        
        return Card(
            title: item.description,
            dueDate: item.dueAt ?? .defaultDate,
            createdDate: item.createdAt,
            isCompleted: $items[index].completed,
            onEdit: { editTask(at: index) },
            onDelete: { deleteTask(at: index) }
        )
        .onChange(of: items[index].completed) {
            update(task: items[index])
        }
        .transition(.scale.combined(with: .move(edge: .leading)))
    }
    
    private func editTask(at index: Int) {
        // TODO: Navigate to EditView
    }
    
    private func update(task: TaskItem) {
        // TODO: Update task completion status
    }
    
    private func deleteTask(at index: Int) {
        withAnimation(.bouncy(duration: 0.75)) {
            _ = items.remove(at: index)
        }
        // TODO: Remove task
    }
}

#Preview {
    struct TaskListViewPreview: View {
        @State private var items = TaskItem.samples
        
        var body: some View {
            TaskListView(items: $items)
        }
    }
    
    return TaskListViewPreview()
}
