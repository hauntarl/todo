//
//  Card.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

/**
 Card component that displays the task details with associated actions.
 
 - Parameters:
    - title: The task title
    - dueDate: The task's due date
    - createdDate: The task's creation date
    - isCompleted: A binding to manage the task's `isCompleted` status
    - onEdit: The action to perform when the edit button is tapped
    - onDelete: The action to perform when the delete button is tapped
 */
struct Card: View {
    let title: String
    let dueDate: Date
    let createdDate: Date
    @Binding var isCompleted: Bool
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            editButton
            Spacer().frame(width: 20)
            details
            Spacer()
            checkbox
            Spacer().frame(width: 20)
            deleteButton
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.taskSecondary)
        }
    }
    
    // Displays the task details
    private var details: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(title)
                .fontWeight(.medium)
                .lineLimit(2)
                .truncationMode(.tail)
            
            Spacer().frame(height: 6)
            
            Text("Due: \(dueDate.formatted)")
                .font(.subheadline)
            
            Spacer().frame(height: 4)
            
            Text("Created: \(createdDate.formatted)")
                .font(.subheadline)
        }
        .foregroundStyle(.taskPrimary)
    }

    // Manages the task's isComplete state
    private var checkbox: some View {
        Checkbox(isSelected: $isCompleted, size: 24)
    }
    
    // Manages the task's edit action
    private var editButton: some View {
        Button(action: onEdit) {
            Image(systemName: "pencil")
        }
        .font(.title2)
        .fontWeight(.black)
        .foregroundStyle(.taskPrimary)
    }
    
    // Manages the task's delete action
    private var deleteButton: some View {
        Button(action: onDelete) {
            Image(systemName: "trash.fill")
        }
        .font(.title2)
        .foregroundStyle(.accent)
    }
}

#Preview {
    struct CardPreview: View {
        @State private var isCompleted = false
        
        var body: some View {
            Card(
                title: "Grocery Shopping",
                dueDate: Date.now,
                createdDate: Date.now,
                isCompleted: $isCompleted
            ) {
                print("Edit button tapped")
            } onDelete: {
                print("Delete button tapped")
            }
            .padding(.horizontal)
        }
    }
    
    return CardPreview()
}
