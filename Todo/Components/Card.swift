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
            Spacer().frame(width: 24)
            details
            Spacer()
            checkbox
            Spacer().frame(width: 15)
            deleteButton
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 14)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.taskSecondary)
        }
    }
    
    // Displays the task details
    private var details: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(title)
                .font(.interMediumBody)
                .lineLimit(2)
                .truncationMode(.tail)
            
            Spacer().frame(height: 5)
            
            Text("Due: \(dueDate.formatted)")
                .font(.interCaption)
            
            Spacer().frame(height: 4)
            
            Text("Created: \(createdDate.formatted)")
                .font(.interCaption)
        }
        .foregroundStyle(.taskPrimary)
    }

    // Manages the task's isComplete state
    private var checkbox: some View {
        ToggleIcon(
            isActive: isCompleted,
            active: .checkboxFilled,
            inactive: .checkbox,
            size: 18.75
        )
        .padding((25 - 18.75) / 2)
        .onTapGesture {
            withAnimation(.bouncy(duration: 0.75)) {
                isCompleted.toggle()
            }
        }
    }
    
    // Manages the task's edit action
    private var editButton: some View {
        Button(action: onEdit) {
            Image.icon(for: .pencil)
                .frame(width: 18.75, height: 18.75)
                .padding((25 - 18.75) / 2)
        }
        .font(.title2)
        .fontWeight(.black)
        .foregroundStyle(.taskPrimary)
    }
    
    // Manages the task's delete action
    private var deleteButton: some View {
        Button(action: onDelete) {
            Image.icon(for: .trash)
                .frame(width: 14, height: 18)
                .padding(.vertical, (24 - 18) / 2)
                .padding(.horizontal, (24 - 14) / 2)
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
