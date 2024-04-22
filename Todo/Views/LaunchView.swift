//
//  LaunchView.swift
//  Todo
//
//  Created by Sameer Mungole on 4/22/24.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var route: TaskNavigation
    
    var body: some View {
        content
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
        case .editTask(_):
            // TODO: Add navigation destination for edit view
            EmptyView()
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
