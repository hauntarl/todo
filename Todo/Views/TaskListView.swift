//
//  TaskListView.swift
//  Todo
//
//  Created by Sameer Mungole on 4/22/24.
//

import SwiftUI

/**
 TaskListView displays the provided task items in a vertical scroll view
 */
struct TaskListView: View {
    @EnvironmentObject var manager: TaskManager
    @EnvironmentObject var route: TaskNavigation
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            navigationTitle
            Spacer().frame(height: 22)
            taskList
        }
        .padding(.horizontal, 16)
        .padding(.top, 67)
        .ignoresSafeArea(edges: .top)
    }
    
    private var navigationTitle: some View {
        HStack(alignment: .center, spacing: .zero) {
            navigationButton {
                route.navigate(to: .settings)
            } icon: {
                Image.icon(for: .gear)
                    .frame(width: 27.24, height: 28)
                    .padding(.horizontal, (35 - 27.24) / 2)
                    .padding(.vertical, (35 - 28) / 2)
                    .foregroundStyle(.taskPrimary)
            }
            
            Spacer()
            
            Text("Task List")
                .font(.interLargeTitle)
                .foregroundStyle(.taskPrimary)
            
            Spacer()
            
            navigationButton {
                route.navigate(to: .newTask)
            } icon: {
                Image.icon(for: .plusCircleFilled)
                    .frame(width: 29.17, height: 29.17)
                    .padding((35 - 29.17) / 2)
                    .foregroundStyle(.taskPrimary)
            }
        }
        .padding(.horizontal, 27 - 16)
    }
    
    private func navigationButton(
        action: @escaping () -> Void,
        icon: () -> some View
    ) -> some View {
        Button(action: action) {
            icon()
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
