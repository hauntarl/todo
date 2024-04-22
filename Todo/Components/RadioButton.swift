//
//  RadioButton.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

/**
 RadioButton component that toggles between two states i.e, `active` and `inactive`.
 
 - Parameters:
    - isActive: Binding that let's you manage the current state of this component
    - size: Defines the size of this component
 */
struct RadioButton: View {
    var isActive: Bool
    var size: Double = 30
    
    var body: some View {
        Circle()
            .stroke(.taskPrimary, lineWidth: size * 0.1)
            .overlay(isActive ? filledCircle : nil)
            .frame(width: size)
    }
    
    // Filled circle that is displayed when the button is active
    private var filledCircle: some View {
        Circle()
            .fill(.taskPrimary)
            .frame(width: size * 0.6)
            .transition(.scale)
    }
}

#Preview {
    struct RadioButtonPreview: View {
        @State private var isActive = false
        
        var body: some View {
            RadioButton(isActive: isActive, size: 60)
                .onTapGesture {
                    withAnimation {
                        isActive.toggle()
                    }
                }
        }
    }
    
    return RadioButtonPreview()
}
