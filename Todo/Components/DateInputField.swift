//
//  DateInputField.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

/**
 DateInputField component that selects and displays a date from the calendar.
 
 - Parameters:
    - date: A binding to manage the currently selected `Date`.
 */
struct DateInputField: View {
    @Binding var date: Date

    @State private var isShowingCalendar = false
    @State private var isDateSelected = false
    
    var body: some View {
        VStack {
            HStack {
                if isDateSelected {
                    content
                }
                Spacer()
                calendarButton
            }
            .padding(12)
            .background(filledRectangle)
        }
        .onChange(of: date) {
            isShowingCalendar = false
            withAnimation {
                isDateSelected = true
            }
        }
    }
    
    // Displays formatted currently selected date
    private var content: some View {
        Text(date.formatted)
            .foregroundStyle(.taskPrimary)
            .transition(.opacity)
    }
    
    // Displays the calendar button to select a date
    private var calendarButton: some View {
        Button {
            isShowingCalendar = true
        } label: {
            Image(systemName: "calendar")
        }
        .foregroundStyle(.taskPrimary)
        .font(.title2)
        .popover(isPresented: $isShowingCalendar) {
            datePicker
                .presentationDetents([.medium])
        }
    }
    
    // Creates a graphical style date picker
    private var datePicker: some View {
        DatePicker(
            "",
            selection: $date,
            in: .now...,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
        .tint(.calendarTint)
        .transition(
            .scale
                .combined(with: .move(edge: .trailing))
                .combined(with: .opacity)
        )
    }
    
    // Displays a background for the component
    private var filledRectangle: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(.taskSecondary)
            .overlay(isDateSelected ? strokedRectangle : nil)
    }
    
    // Displays a border around the component
    private var strokedRectangle: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(.taskPrimary, lineWidth: 1)
            .padding(0.5)
    }
}

#Preview {
    struct DateInputFieldPreview: View {
        @State private var date: Date = .now
        
        var body: some View {
            VStack {
                DateInputField(date: $date.animation())
                Spacer()
            }
            .padding()
        }
    }
    
    return DateInputFieldPreview()
}
