//
//  ToggleIcon.swift
//  Todo
//
//  Created by Sameer Mungole on 4/23/24.
//

import SwiftUI

/**
 ToggleIcon component that toggles between two states i.e, `active` and `inactive`.
 
 - Parameters:
    - isActive: The current state of the icon
    - active: Icon when component is active
    - inactive: Icon when component is inactive
    - size: Defines the size for this component
 */
struct ToggleIcon: View {
    let isActive: Bool
    let active: ImageResource
    let inactive: ImageResource
    var size: Double = 30

    var body: some View {
        Group {
            if isActive {
                Image.icon(for: active)
                    .transition(.scale)
            } else {
                Image.icon(for: inactive)
                    .transition(.blurReplace)
            }
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    struct ToggleIconPreview: View {
        @State private var isSelected = false
        
        var body: some View {
            VStack(spacing: 20) {
                ToggleIcon(
                    isActive: isSelected,
                    active: .checkboxFilled,
                    inactive: .checkbox,
                    size: 60
                )
                .onTapGesture {
                    withAnimation {
                        isSelected.toggle()
                    }
                }
                
                ToggleIcon(
                    isActive: isSelected,
                    active: .radioButtonFilled,
                    inactive: .radioButton,
                    size: 60
                )
                .onTapGesture {
                    withAnimation {
                        isSelected.toggle()
                    }
                }
            }
        }
    }
    
    return ToggleIconPreview()
}
