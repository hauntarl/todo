//
//  EditView.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

/**
 EditView is responsible for updating an already existing task
 */
struct EditView: View {
    let item: TaskItem
    
    @EnvironmentObject private var manager: TaskManager
    @EnvironmentObject private var route: TaskNavigation
    @State private var editItem: TaskItem
    @State private var isSaveButtonDisabled = false
    
    var body: some View {
        UpdateView(
            title: "Edit",
            description: $editItem.description.animation(),
            dueDate: $editItem.dueAt.animation(),
            isSaveButtonDisabled: isSaveButtonDisabled,
            onSave: save
        )
    }
    
    init(item: TaskItem) {
        self.item = item
        self._editItem = .init(initialValue: item)
    }
    
    private func save() {
        // TODO: Save the edited task
        guard editItem != item else {
            route.dismiss()
            return
        }
        
        Task {
            await manager.edit(task: editItem)
            if manager.errorMessage == nil {
                route.dismiss()
            }
        }
    }
}

#Preview {
    struct EditViewPreview: View {
        @StateObject private var manager = TaskManager()
        @StateObject private var route = TaskNavigation()
        
        var body: some View {
            NavigationStack(path: $route.path) {
                if let item = manager.items.first {
                    EditView(item: item)
                }
            }
            .environmentObject(manager)
            .environmentObject(route)
        }
    }
    return EditViewPreview()
}
