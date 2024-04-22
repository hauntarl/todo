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
    @EnvironmentObject private var route: TaskNavigation
    @State private var newTask = NewTask()
    
    var body: some View {
        UpdateView(
            title: "Create",
            description: $newTask.description.animation(),
            dueDate: $newTask.dueAt.animation()
        ) {
            // TODO: Save the newly created task
            route.dismiss()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    struct CreateViewPreview: View {
        @StateObject private var route = TaskNavigation()
        
        var body: some View {
            NavigationStack(path: $route.path) {
                CreateView()
            }
            .environmentObject(route)
        }
    }
    return CreateViewPreview()
}
