//
//  TodoApp.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

@main
struct TodoApp: App {
    @StateObject private var route = TaskNavigation()
    @StateObject private var settings = Settings()
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(route)
                .environmentObject(settings)
                .preferredColorScheme(.light)
        }
    }
}
