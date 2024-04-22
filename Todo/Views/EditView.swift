//
//  EditView.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

struct EditView: View {
    let item: TaskItem
    let onSuccess: (TaskItem) -> Void
    
    @State private var editItem: TaskItem
    
    var body: some View {
        UpdateView(
            title: "Edit",
            description: $editItem.description.animation(),
            dueDate: $editItem.dueAt.animation()
        ) {
            // TODO: Save the edited task
            onSuccess(editItem)
        }
    }
    
    init(item: TaskItem, onSuccess: @escaping (TaskItem) -> Void) {
        self.item = item
        self.onSuccess = onSuccess
        self._editItem = .init(initialValue: item)
    }
}

#Preview {
    EditView(item: TaskItem.samples[0]) { item in
        print("Item edited successfully: \(item)")
    }
}
