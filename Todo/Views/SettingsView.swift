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
                buildOption(isActive: settings.filterBy == option, name: option.rawValue) {
                    withAnimation(.bouncy(duration: 0.75)) {
                        settings.filterBy = option
                    }
                }
            }
            .font(.interBody)
            .padding(.leading, 4)
        }
        .foregroundStyle(.taskPrimary)
    }
    
    private var sortByOptions: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Sort By")
                .font(.interTitle)
            
            ForEach(Settings.SortBy.allCases, id: \.self) { option in
                buildOption(isActive: settings.sortBy == option, name: option.rawValue) {
                    withAnimation(.bouncy(duration: 0.75)) {
                        settings.sortBy = option
                    }
                }
            }
            .font(.interBody)
            .padding(.leading, 4)
        }
        .foregroundStyle(.taskPrimary)
    }
    
    private var orderByOptions: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Order By")
                .font(.interTitle)
            
            ForEach(Settings.OrderBy.allCases, id: \.self) { option in
                buildOption(isActive: settings.orderBy == option, name: option.rawValue) {
                    withAnimation(.bouncy(duration: 0.75)) {
                        settings.orderBy = option
                    }
                }
            }
            .font(.interBody)
            .padding(.leading, 4)
        }
        .foregroundStyle(.taskPrimary)
    }
    
    private func buildOption(
        isActive: Bool,
        name: String,
        action: @escaping () -> Void
    ) -> some View {
        HStack(alignment: .center, spacing: 20) {
            ToggleIcon(
                isActive: isActive,
                active: .radioButtonFilled,
                inactive: .radioButton,
                size: 20
            )
            Text(name)
        }
        .onTapGesture(perform: action)
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
