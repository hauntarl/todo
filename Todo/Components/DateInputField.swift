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
    @Binding var date: Date?
    let onTapCalendar: () -> Void

    @State private var isShowingCalendar = false
    
    var body: some View {
        VStack {
            HStack {
                if date != nil {
                    content
                }
                Spacer()
                calendarButton
            }
            .padding(12)
            .background(filledRectangle)
        }
    }
    
    // Displays formatted currently selected date
    private var content: some View {
        Text(date?.formatted ?? "")
            .foregroundStyle(.taskPrimary)
            .transition(.opacity)
    }
    
    // Displays the calendar button to select a date
    private var calendarButton: some View {
        Button {
            isShowingCalendar = true
            onTapCalendar()
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
            selection: Binding(
                get: { date ?? .now },
                set: { date = $0 }
            ),
            displayedComponents: [.date]
        ) {
            EmptyView()
        }
        .datePickerStyle(.graphical)
        .tint(.calendarTint)
        .frame(width: 320)
        .preferredColorScheme(.light)
        .transition(
            .scale
                .combined(with: .move(edge: .trailing))
                .combined(with: .opacity)
        )
        .onAppear {
            if date == nil {
                date = .now
            }
        }
    }
    
    // Displays a background for the component
    private var filledRectangle: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(.taskSecondary)
            .overlay(date != nil ? strokedRectangle : nil)
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
        @State private var date: Date?
        
        var body: some View {
            VStack {
                DateInputField(date: $date.animation()) {
                    // Do nothing
                }
                Spacer()
            }
            .padding()
        }
    }
    
    return DateInputFieldPreview()
}
