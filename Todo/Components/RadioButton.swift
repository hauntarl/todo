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
    @Binding var isActive: Bool
    var size: Double = 30
    
    var body: some View {
        Circle()
            .stroke(.black, lineWidth: size * 0.1)
            .overlay {
                if isActive {
                    Circle()
                        .frame(width: size * 0.6)
                        .transition(.scale)
                }
            }
            .frame(width: size)
            .onTapGesture {
                isActive.toggle()
            }
    }
}

#Preview {
    struct RadioButtonPreview: View {
        @State private var isActive = false
        
        var body: some View {
            RadioButton(isActive: $isActive.animation(), size: 60)
        }
    }
    
    return RadioButtonPreview()
}
