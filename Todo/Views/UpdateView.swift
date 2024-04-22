//
//  UpdateView.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

/**
 UpdateView is a reusable view, utilized by **CreateView** and **EditView** to take user
 input for new or existing task respectively.
 
 - Parameters:
    - title: The navigation title for this view
    - description: A binding to manage the task description
    - dueDate: A binding to manage the due date for this task
    - onSave: Action to perform when user taps the save button
 */
struct UpdateView: View {
    let title: String
    @Binding var description: String
    @Binding var dueDate: Date?
    let onSave: () -> Void
    
    @FocusState private var isDescriptionFieldFocused
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            navigationTitle
            Spacer().frame(height: 40)
            taskDescription
            Spacer().frame(height: 20)
            taskDueDate
            Spacer().frame(height: 40)
            saveButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal)
    }
    
    var navigationTitle: some View {
        Text(title)
            .font(.largeTitle)
    }
    
    var taskDescription: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("To-Do Item Name")
            TextInputField(text: $description)
                .focused($isDescriptionFieldFocused)
        }
        .padding(.horizontal)
    }
    
    var taskDueDate: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Select Due Date")
            DateInputField(date: $dueDate)
        }
        .padding(.horizontal)
    }
    
    var saveButton: some View {
        Button("Save") {
            isDescriptionFieldFocused = false
            onSave()
        }
        .foregroundStyle(.taskBackground)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(.taskPrimary)
        }
    }
}

#Preview {
    struct UpdateViewPreview: View {
        @State private var description = ""
        @State private var dueDate: Date?
        
        var body: some View {
            UpdateView(
                title: "Create/Edit",
                description: $description.animation(),
                dueDate: $dueDate.animation()
            ) {
                print("Save button tapped")
            }
        }
    }
    
    return UpdateViewPreview()
}
