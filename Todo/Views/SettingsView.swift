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
            
            Spacer().frame(height: 33)
            
            Group {
                filterOptions
                Spacer().frame(height: 17)
                sortByOptions
                Spacer().frame(height: 17)
                orderByOptions
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 21)
            
            Spacer().frame(height: 47)
            saveButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 12)
        .padding(.top, 67)
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
    }
    
    private var navigationTitle: some View {
        ZStack(alignment: .leading) {
            Button(action: route.dismiss) {
                Label("Back", systemImage: "chevron.left")
            }
            .font(.interTitle2)
            .foregroundStyle(.accent)
            
            Text("Settings")
                .font(.interLargeTitle)
                .foregroundStyle(.taskPrimary)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    private var filterOptions: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text("Filters")
                .font(.interTitle)
            
            Spacer().frame(height: 14)
            
            ForEach(Settings.FilterBy.allCases, id: \.self) { option in
                buildOption(isActive: settings.filterBy == option, name: option.rawValue) {
                    withAnimation(.bouncy(duration: 0.75)) {
                        settings.filterBy = option
                    }
                }
            }
            .font(.interBody)
            .padding(.leading, 1)
        }
        .foregroundStyle(.taskPrimary)
    }
    
    private var sortByOptions: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text("Sort By")
                .font(.interTitle)
            
            Spacer().frame(height: 14)
            
            ForEach(Settings.SortBy.allCases, id: \.self) { option in
                buildOption(isActive: settings.sortBy == option, name: option.rawValue) {
                    withAnimation(.bouncy(duration: 0.75)) {
                        settings.sortBy = option
                    }
                }
            }
            .font(.interBody)
            .padding(.leading, 1)
        }
        .foregroundStyle(.taskPrimary)
    }
    
    private var orderByOptions: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text("Sort Date Direction")
                .font(.interTitle)
            
            Spacer().frame(height: 14)
            
            ForEach(Settings.OrderBy.allCases, id: \.self) { option in
                buildOption(isActive: settings.orderBy == option, name: option.rawValue) {
                    withAnimation(.bouncy(duration: 0.75)) {
                        settings.orderBy = option
                    }
                }
            }
            .font(.interBody)
            .padding(.leading, 1)
        }
        .foregroundStyle(.taskPrimary)
    }
    
    private func buildOption(
        isActive: Bool,
        name: String,
        action: @escaping () -> Void
    ) -> some View {
        HStack(alignment: .center, spacing: 17) {
            ToggleIcon(
                isActive: isActive,
                active: .radioButtonFilled,
                inactive: .radioButton,
                size: 20.23
            )
            .padding((25 - 20.23) / 2)
            
            Text(name)
        }
        .padding(.bottom, 16)
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
