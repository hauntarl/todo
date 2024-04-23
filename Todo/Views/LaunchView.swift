//
//  LaunchView.swift
//  Todo
//
//  Created by Sameer Mungole on 4/22/24.
//

import SwiftUI

/** 
 The entry point for the application
 */
struct LaunchView: View {
    @EnvironmentObject private var manager: TaskManager
    @EnvironmentObject private var route: TaskNavigation
    @EnvironmentObject private var settings: Settings
    @State private var showingContent = false
    @State private var errorPopupMessage: String = ""
    @State private var errorPopupTask: Task<Void, Never>?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if showingContent {
                content
                    .zIndex(1)
                    .transition(.move(edge: .trailing))
            } else {
                loading
                    .zIndex(1)
                    .transition(.move(edge: .leading))
            }
            
            if !errorPopupMessage.isEmpty {
                errorPopup
                    .zIndex(2)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .onChange(of: manager.errorMessage) { _, newValue in
            updateErrorPopup(with: newValue ?? "")
        }
    }
    
    /// Main content of the app
    private var content: some View {
        NavigationStack(path: $route.path) {
            TaskListView()
                .navigationDestination(
                    for: TaskNavigation.Destination.self,
                    destination: destination
                )
        }
    }
    
    /// Navigation destination controller
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
    
    private var loading: some View {
        ZStack(alignment: .bottom) {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Loading tasks...")
                    .font(.interTitle2)
                    .foregroundStyle(.accent)
                
                ProgressView()
            }
            .padding(.bottom, 100)
        }
        .task {
            await fetchTasks()
        }
    }
    
    /// Displays an error message as a pop-up
    private var errorPopup: some View {
        Text(errorPopupMessage)
            .font(.interBody)
            .foregroundStyle(.taskBackground)
            .lineLimit(3)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.accent)
                    .shadow(radius: 10)
            }
            .padding()
    }
    
    /// Fetches task list
    private func fetchTasks() async {
        await manager.fetchTasks(for: settings)
        
        // TODO: Remove once the api uses persistent storage
        // Create samples when the api doesn't have any tasks
        // Comment the below if-block if you don't want to pre-populate the server
        if manager.items.isEmpty {
            await createSamples()
            await manager.fetchTasks(for: settings)
            print("Pre-populated server with samples.")
        }
        
        if manager.errorMessage == nil {
            withAnimation(.bouncy(duration: 0.75)) {
                showingContent = true
            }
        }
    }
    
    /// Controls the lifetime of error pop-up when a new error is generated
    /// by the app
    private func updateErrorPopup(with message: String) {
        withAnimation(.bouncy(duration: 0.75)) {
            errorPopupMessage = message
        }
        
        errorPopupTask?.cancel()
        if !message.isEmpty {
            errorPopupTask = Task {
                for _ in 0..<5 {
                    if Task.isCancelled {
                        return
                    }
                    try? await Task.sleep(for: .seconds(1))
                }
                if Task.isCancelled {
                    return
                }
                manager.errorMessage = nil
            }
        }
    }
    
    /// As the api is currently using in-memory database, this function pre-populates
    /// the database with some sample tasks, intentionally done for demo purposes.
    /// `TODO:` Remove once the api uses persistent storage
    private func createSamples() async {
        await withTaskGroup(of: Void.self) { group in
            for item in NewTask.samples {
                group.addTask {
                    await manager.create(task: item)
                }
            }
        }
    }
}

#Preview {
    struct LaunchViewPreview: View {
        @StateObject private var manager = TaskManager()
        @StateObject private var route = TaskNavigation()
        @StateObject private var settings = Settings()
        
        var body: some View {
            LaunchView()
                .environmentObject(manager)
                .environmentObject(route)
                .environmentObject(settings)
        }
    }
    
    return LaunchViewPreview()
        .preferredColorScheme(.light)
}
