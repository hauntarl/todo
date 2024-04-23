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
    let isSaveButtonDisabled: Bool
    let onSave: () -> Void
    
    @EnvironmentObject private var route: TaskNavigation
    @FocusState private var isDescriptionFieldFocused
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            navigationTitle
            Spacer().frame(height: 35)
            taskDescription
            Spacer().frame(height: 19)
            taskDueDate
            Spacer().frame(height: 54)
            saveButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 12)
        .padding(.top, 67)
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
    }
    
    var navigationTitle: some View {
        ZStack(alignment: .leading) {
            Button(action: route.dismiss) {
                Label("Back", systemImage: "chevron.left")
            }
            .font(.interTitle2)
            .foregroundStyle(.accent)
            
            Text(title)
                .font(.interLargeTitle)
                .foregroundStyle(.taskPrimary)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var taskDescription: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("To-Do Item Name")
                .font(.interBody)
                .foregroundStyle(.taskPrimary)
            
            TextInputField(text: $description)
                .focused($isDescriptionFieldFocused)
        }
        .padding(.horizontal, 29 - 12)
    }
    
    var taskDueDate: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Select Due Date")
                .font(.interBody)
                .foregroundStyle(.taskPrimary)
            
            DateInputField(date: $dueDate) {
                isDescriptionFieldFocused = false
            }
        }
        .padding(.horizontal, 29 - 12)
    }
    
    var saveButton: some View {
        Button("Save") {
            isDescriptionFieldFocused = false
            onSave()
        }
        .font(.interTitle2)
        .foregroundStyle(.taskBackground)
        .disabled(isSaveButtonDisabled)
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background {
            RoundedRectangle(cornerRadius: 4)
                .fill(isSaveButtonDisabled ? .accent : .taskPrimary)
        }
        .animation(.default, value: isSaveButtonDisabled)
    }
}

#Preview {
    struct UpdateViewPreview: View {
        @StateObject private var route = TaskNavigation()
        @State private var description = ""
        @State private var dueDate: Date?
        
        var body: some View {
            NavigationStack(path: $route.path) {
                UpdateView(
                    title: "Create/Edit",
                    description: $description.animation(),
                    dueDate: $dueDate.animation(),
                    isSaveButtonDisabled: false
                ) {
                    print("Save button tapped")
                }
            }
            .environmentObject(route)
        }
    }
    
    return UpdateViewPreview()
}
