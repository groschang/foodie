//
//  MenuView.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct MenuView: View {

    @StateObject private var viewModel = MenuViewModel()

    var body: some View {
        content
            .navigationTitle(String(localized: "Settings"))
    }

    var content: some View {
        List {

            Section(String(localized: "Color theme")) {
                HStack(spacing: 6) {
                    Spacer()

                    VStack(alignment: .trailing) {

                        Button(String(localized: "System default")) {
                            viewModel.setTheme(.system)
                        }
                        .buttonStyle(.menu(selected: viewModel.appTheme == .system))

                        Button(String(localized: "Light")) {
                            viewModel.setTheme(.light)
                        }
                        .buttonStyle(.menu(selected: viewModel.appTheme == .light))

                        Button(String(localized: "Dark")) {
                            viewModel.setTheme(.dark)
                        }
                        .buttonStyle(.menu(selected: viewModel.appTheme == .dark))
                    }
                }
            }

            Section(String(localized: "Notifications")) {
                HStack(spacing: 6) {
                    Spacer()

                    VStack(alignment: .trailing) {

                        Text("Status: *\(viewModel.notificationsStatus)*")

                        if viewModel.showEnableNotifications {
                            Button(String(localized: "Enable notifications")) {
                                viewModel.enableNotificationsInSettings()
                            }
                            .buttonStyle(.menu(selected: true))
                        }

                        if viewModel.showAuthorizeNotifications {
                            Button(String(localized: "Authorize notifications")) {
                                viewModel.requestNotificationsPermission()
                            }
                            .buttonStyle(.menu(selected: true))
                        }
                    }
                }
            }
        }
        .padding()
        .listStyle(SidebarListStyle())
    }
}

//MARK: - Preview

#Preview {
    MenuView()
}
