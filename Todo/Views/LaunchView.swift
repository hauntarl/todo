//
//  LaunchView.swift
//  Todo
//
//  Created by Sameer Mungole on 4/22/24.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var route: TaskNavigation
    @State private var showingContent = false
    
    var body: some View {
        if showingContent {
            content
                .transition(.move(edge: .trailing))
        } else {
            loading
                .transition(.move(edge: .leading))
        }
    }
    
    private var content: some View {
        NavigationStack(path: $route.path) {
            TaskListView()
                .navigationDestination(
                    for: TaskNavigation.Destination.self,
                    destination: destination
                )
        }
    }
    
    @ViewBuilder
    private func destination(for value: TaskNavigation.Destination) -> some View {
        switch value {
        case .settings:
            SettingsView()
        case .newTask:
            CreateView()
        case .editTask(let item):
            EditView(item: item) { editedItem in
                // TODO: Update edited task
                print("\(editedItem.description)", terminator: ", ")
                print("\((editedItem.dueAt ?? .defaultDate).formatted)")
            }
        }
    }
    
    private var loading: some View {
        ZStack(alignment: .bottom) {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Loading samples...")
                    .foregroundStyle(.accent)
                ProgressView()
            }
        }
        .onAppear(perform: loadTasks)
    }
    
    private func loadTasks() {
        Task {
            try? await Task.sleep(for: .seconds(2))
            withAnimation(.bouncy(duration: 0.75)) {
                showingContent = true
            }
        }
    }
}

#Preview {
    struct LaunchViewPreview: View {
        @StateObject private var route = TaskNavigation()
        @StateObject private var settings = Settings()
        
        var body: some View {
            LaunchView()
                .environmentObject(route)
                .environmentObject(settings)
        }
    }
    
    return LaunchViewPreview()
        .preferredColorScheme(.light)
}
