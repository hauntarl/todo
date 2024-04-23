//
//  TextInputField.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

/**
 TextInputField component is a wrapper around the `TextField` component.
 
 - Parameters:
    - text: A binding to manage the input `text`.
 */
struct TextInputField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("", text: $text.animation())
            .font(.interBody)
            .foregroundStyle(.taskPrimary)
            .textInputAutocapitalization(.words)
            .textFieldStyle(.plain)
            .padding(11)
            .background(filledRectangle)
    }
    
    // Displays a background for the component
    private var filledRectangle: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(.taskSecondary)
            .overlay(!text.isEmpty ? strokedRectangle : nil)
    }
    
    // Displays a border around the component
    private var strokedRectangle: some View {
        RoundedRectangle(cornerRadius: 3)
            .stroke(.taskPrimary, lineWidth: 1)
            .padding(0.5)
    }
}

#Preview {
    struct TextInputFieldPreview: View {
        @State private var text = ""
        
        var body: some View {
            TextInputField(text: $text)
                .padding()
        }
    }
    
    return TextInputFieldPreview()
}
