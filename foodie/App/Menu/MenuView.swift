//
//  MenuView.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//

import SwiftUI

struct MenuView: View {

    @ObservedObject var viewModel = MenuViewModel()

    @AppStorage(UserDefaultsKeys.appTheme) var appTheme: AppTheme = .system

    var body: some View {
        content
            .navigationTitle("Settings")
    }

    var content: some View {
        List {

            Section("Color theme") {

                HStack(spacing: 6) {

                    Spacer()

                    VStack(alignment: .trailing) {
                        Button("Default") {
                            appTheme = .system
                        }
                        .buttonStyle(MenuButtonStyle(selected: appTheme == .system))

                        Button("Light") {
                            appTheme = .light
                        }
                        .buttonStyle(MenuButtonStyle(selected: appTheme == .light))

                        Button("Dark") {
                            appTheme = .dark
                        }
                        .buttonStyle(MenuButtonStyle(selected: appTheme == .dark))
                    }
                }
            }
        }
        .padding()
        .listStyle(SidebarListStyle())
    }
}

#Preview {
    MenuView()
}
