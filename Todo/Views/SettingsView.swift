//
//  SettingsView.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var settings: Settings
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            navigationTitle
            Spacer().frame(height: 40)
            filterOptions
            Spacer().frame(height: 40)
            sortByOptions
            Spacer().frame(height: 40)
            orderByOptions
            Spacer().frame(height: 40)
            saveButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal)
    }
    
    private var navigationTitle: some View {
        Text("Settings")
            .font(.largeTitle)
    }
    
    private var filterOptions: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Filters")
                .font(.title2)
            
            ForEach(Settings.Filter.allCases, id: \.self) { option in
                HStack(alignment: .center, spacing: 20) {
                    RadioButton(isActive: settings.filter == option, size: 20)
                    Text(option.rawValue)
                }
                .onTapGesture {
                    withAnimation {
                        settings.filter = option
                    }
                }
            }
            .padding(.leading, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    private var sortByOptions: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Sort By")
                .font(.title2)
            
            ForEach(Settings.SortBy.allCases, id: \.self) { option in
                HStack(alignment: .center, spacing: 20) {
                    RadioButton(isActive: settings.sortBy == option, size: 20)
                    Text(option.rawValue)
                }
                .onTapGesture {
                    withAnimation {
                        settings.sortBy = option
                    }
                }
            }
            .padding(.leading, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    private var orderByOptions: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Order By")
                .font(.title2)
            
            ForEach(Settings.OrderBy.allCases, id: \.self) { option in
                HStack(alignment: .center, spacing: 20) {
                    RadioButton(isActive: settings.orderBy == option, size: 20)
                    Text(option.rawValue)
                }
                .onTapGesture {
                    withAnimation {
                        settings.orderBy = option
                    }
                }
            }
            .padding(.leading, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    private var saveButton: some View {
        Button("Save") {
            // TODO: Save settings and update tasks based on new filters
        }
        .foregroundStyle(.taskBackground)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(.taskPrimary)
        }
    }
}

#Preview {
    struct SettingsViewPreview: View {
        @State private var settings = Settings()
        
        var body: some View {
            SettingsView(settings: $settings)
        }
    }
    return SettingsViewPreview()
}
