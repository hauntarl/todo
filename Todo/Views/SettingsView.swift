//
//  SettingsView.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import SwiftUI

/**
 SettingsView displays all the available filter and sort options for the task list
 */
struct SettingsView: View {
    @EnvironmentObject private var manager: TaskManager
    @EnvironmentObject private var route: TaskNavigation
    @EnvironmentObject private var settings: Settings
    @State private var isSaveButtonDisabled = false
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            navigationTitle
            Spacer().frame(height: 40)
            
            Group {
                filterOptions
                Spacer().frame(height: 40)
                sortByOptions
                Spacer().frame(height: 40)
                orderByOptions
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Spacer().frame(height: 40)
            saveButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal)
        .navigationBarBackButtonHidden()
    }
    
    private var navigationTitle: some View {
        Text("Settings")
            .font(.interLargeTitle)
            .foregroundStyle(.taskPrimary)
    }
    
    private var filterOptions: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Filters")
                .font(.interTitle)
            
            ForEach(Settings.FilterBy.allCases, id: \.self) { option in
                HStack(alignment: .center, spacing: 20) {
                    RadioButton(isActive: settings.filter == option, size: 20)
                    Text(option.rawValue)
                }
                .font(.interBody)
                .onTapGesture {
                    withAnimation {
                        settings.filter = option
                    }
                }
            }
            .padding(.leading, 4)
        }
        .foregroundStyle(.taskPrimary)
    }
    
    private var sortByOptions: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Sort By")
                .font(.interTitle)
            
            ForEach(Settings.SortBy.allCases, id: \.self) { option in
                HStack(alignment: .center, spacing: 20) {
                    RadioButton(isActive: settings.sortBy == option, size: 20)
                    Text(option.rawValue)
                }
                .font(.interBody)
                .onTapGesture {
                    withAnimation {
                        settings.sortBy = option
                    }
                }
            }
            .padding(.leading, 4)
        }
        .foregroundStyle(.taskPrimary)
    }
    
    private var orderByOptions: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Order By")
                .font(.interTitle)
            
            ForEach(Settings.OrderBy.allCases, id: \.self) { option in
                HStack(alignment: .center, spacing: 20) {
                    RadioButton(isActive: settings.orderBy == option, size: 20)
                    Text(option.rawValue)
                }
                .font(.interBody)
                .onTapGesture {
                    withAnimation {
                        settings.orderBy = option
                    }
                }
            }
            .padding(.leading, 4)
        }
        .foregroundStyle(.taskPrimary)
    }
    
    private var saveButton: some View {
        Button("Save") {
            isSaveButtonDisabled = true
            Task {
                await manager.fetchTasks(for: settings)
                isSaveButtonDisabled = false
                route.dismiss()
            }
        }
        .font(.interTitle2)
        .foregroundStyle(.taskBackground)
        .disabled(isSaveButtonDisabled)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(isSaveButtonDisabled ? .accent : .taskPrimary)
        }
        .animation(.default, value: isSaveButtonDisabled)
    }
}

#Preview {
    struct SettingsViewPreview: View {
        @StateObject private var manager = TaskManager()
        @StateObject private var route = TaskNavigation()
        @StateObject private var settings = Settings()
        
        var body: some View {
            NavigationStack(path: $route.path) {
                SettingsView()
            }
            .environmentObject(manager)
            .environmentObject(route)
            .environmentObject(settings)
        }
    }
    
    return SettingsViewPreview()
}
