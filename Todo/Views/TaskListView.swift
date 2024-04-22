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
    @State var items: [TaskItem] = TaskItem.samples
    
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
                // TODO: Open settings
            }
            
            Spacer()
            
            Text("Task List")
                .font(.largeTitle)
            
            Spacer()
            
            navigationButton(icon: "plus.circle.fill") {
                // TODO: Open new task view
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
    TaskListView()
}
