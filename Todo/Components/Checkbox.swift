//
//  Checkbox.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

/**
 Checkbox component that toggles between two states i.e, `selected` and `deselected`.
 
 - Parameters:
    - isSelected: Binding that let's you manage the current state of this component
    - size: Defines the size of this component
 */
struct Checkbox: View {
    @Binding var isSelected: Bool
    var size: Double = 30

    var body: some View {
        Group {
            if isSelected {
                filledRectangle
                    .transition(.scale)
            } else {
                borderedRectangle
                    .transition(.scale)
            }
        }
        .frame(width: size, height: size)
        .onTapGesture {
            withAnimation {
                isSelected.toggle()
            }
        }
    }
    
    private var strokeWidth: Double {
        size / 10
    }
    
    private var borderedRectangle: some View {
        RoundedRectangle(cornerRadius: strokeWidth)
            .stroke(.taskPrimary, lineWidth: strokeWidth)
            .padding(strokeWidth / 2)
    }
    
    private var filledRectangle: some View {
        RoundedRectangle(cornerRadius: size / 7)
            .fill(.taskPrimary)
            .overlay {
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .bold()
                    .frame(width: size / 1.5)
            }
    }
}

#Preview {
    struct CheckboxPreview: View {
        @State private var isSelected = false
        
        var body: some View {
            Checkbox(isSelected: $isSelected.animation(), size: 60)
        }
    }
    
    return CheckboxPreview()
}
