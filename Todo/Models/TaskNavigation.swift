//
//  TaskNavigation.swift
//  Todo
//
//  Created by Sameer Mungole on 4/22/24.
//

import SwiftUI

/**
 The **TaskNavigation** model controls the the app's navigation stack
 */
class TaskNavigation: ObservableObject {
    @Published var path = NavigationPath()
    
    enum Destination: Hashable {
        case settings
        case newTask
        case editTask(item: TaskItem)
    }
    
    /// Convenience wrapper to restrict navigation to only `Destination` type,
    /// as the `NavigationPath` holds type-erased list of data.
    func navigate(to destination: Destination) {
        path.append(destination)
    }
    
    /// Safely pops the last element from the `NavigationPath`.
    func dismiss() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
