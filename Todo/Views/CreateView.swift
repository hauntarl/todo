//
//  CreateView.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

struct CreateView: View {
    @State private var newTask = NewTask()
    
    var body: some View {
        UpdateView(
            title: "Create",
            description: $newTask.description.animation(),
            dueDate: $newTask.dueAt.animation()
        ) {
            // TODO: Save the newly created task
        }
    }
}

#Preview {
    CreateView()
}
