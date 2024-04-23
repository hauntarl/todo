//
//  TodoApp.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        Font.load(name: "Inter-Regular", withExtension: "ttf")
        Font.load(name: "Inter-Medium", withExtension: "ttf")
        return true
    }
}

@main
struct TodoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var manager = TaskManager()
    @StateObject private var route = TaskNavigation()
    @StateObject private var settings = Settings()
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(manager)
                .environmentObject(route)
                .environmentObject(settings)
                .preferredColorScheme(.light)
        }
    }
}
