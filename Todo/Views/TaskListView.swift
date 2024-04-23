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
    @EnvironmentObject var manager: TaskManager
    @EnvironmentObject var route: TaskNavigation
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            navigationTitle
            Spacer().frame(height: 20)
            taskList
        }
        .padding(.horizontal)
    }
    
    private var navigationTitle: some View {
        HStack(alignment: .firstTextBaseline, spacing: .zero) {
            navigationButton(icon: "gearshape.fill") {
                route.navigate(to: .settings)
            }
            
            Spacer()
            
            Text("Task List")
                .font(.largeTitle)
            
            Spacer()
            
            navigationButton(icon: "plus.circle.fill") {
                route.navigate(to: .newTask)
            }
        }
        .padding(.horizontal)
    }
    
    private func navigationButton(
        icon: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(.taskPrimary)
        }
    }
}

#Preview {
    struct TaskListViewPreview: View {
        @StateObject private var manager = TaskManager()
        @StateObject private var route = TaskNavigation()
        @StateObject private var settings = Settings()
        
        var body: some View {
            NavigationStack(path: $route.path) {
                TaskListView()
                    .navigationDestination(
                        for: TaskNavigation.Destination.self,
                        destination: destination
                    )
                    .task {
                        await manager.fetchTasks(for: settings)
                    }
            }
            .environmentObject(manager)
            .environmentObject(route)
            .environmentObject(settings)
        }
        
        @ViewBuilder
        private func destination(for value: TaskNavigation.Destination) -> some View {
            switch value {
            case .settings:
                SettingsView()
            case .newTask:
                CreateView()
            case .editTask(let item):
                EditView(item: item)
            }

        }
    }
    
    return TaskListViewPreview()
}
