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
    let onEdited: (TaskItem) -> Void
    
    @EnvironmentObject private var route: TaskNavigation
    @State private var editItem: TaskItem
    
    var body: some View {
        UpdateView(
            title: "Edit",
            description: $editItem.description.animation(),
            dueDate: $editItem.dueAt.animation()
        ) {
            // TODO: Save the edited task
            if editItem != item {
                onEdited(editItem)
            }
            route.dismiss()
        }
        .navigationBarBackButtonHidden()
    }
    
    init(item: TaskItem, onEdited: @escaping (TaskItem) -> Void) {
        self.item = item
        self.onEdited = onEdited
        self._editItem = .init(initialValue: item)
    }
}

#Preview {
    struct EditViewPreview: View {
        @StateObject private var route = TaskNavigation()
        
        var body: some View {
            NavigationStack(path: $route.path) {
                EditView(item: TaskItem.samples[0]) { newValue in
                    print("Item edited:")
                    print("\t\(newValue.description)")
                    print("\t\((newValue.dueAt ?? .defaultDate).formatted)")
                }
            }
            .environmentObject(route)
        }
    }
    return EditViewPreview()
}
