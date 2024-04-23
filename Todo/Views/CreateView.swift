//
//  CreateView.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

/**
 CreateView is responsible for creating a new task
 */
struct CreateView: View {
    @EnvironmentObject private var manager: TaskManager
    @EnvironmentObject private var route: TaskNavigation
    @State private var newTask = NewTask()
    @State private var isSaveButtonDisabled = false
    
    var body: some View {
        UpdateView(
            title: "Create",
            description: $newTask.description.animation(),
            dueDate: $newTask.dueAt.animation(),
            isSaveButtonDisabled: isSaveButtonDisabled,
            onSave: save
        )
    }
    
    private func save() {
        guard newTask.dueAt != nil else {
            manager.errorMessage = "Select a due date for the task"
            return
        }
        
        isSaveButtonDisabled = true
        Task {
            await manager.create(task: newTask)
            isSaveButtonDisabled = false
            if manager.errorMessage == nil {
                route.dismiss()
            }
        }
    }
}

#Preview {
    struct CreateViewPreview: View {
        @StateObject private var manager = TaskManager()
        @StateObject private var route = TaskNavigation()
        
        var body: some View {
            NavigationStack(path: $route.path) {
                CreateView()
            }
            .environmentObject(manager)
            .environmentObject(route)
        }
    }
    return CreateViewPreview()
}
