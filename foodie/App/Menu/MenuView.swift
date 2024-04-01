//
//  MenuView.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct MenuView: View {

    @Environment(\.presentationMode) var presentationMode

    @ObservedObject private var viewModel = MenuViewModel()

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

                        Button("System default") {
                            viewModel.setTheme(.system)
                        }
                        .buttonStyle(.menu(selected: viewModel.appTheme == .system))

                        Button("Light") {
                            viewModel.setTheme(.light)
                        }
                        .buttonStyle(.menu(selected: viewModel.appTheme == .light))

                        Button("Dark") {
                            viewModel.setTheme(.dark)
                        }
                        .buttonStyle(.menu(selected: viewModel.appTheme == .dark))
                    }
                }
            }

            Section("Notifications") {

                HStack(spacing: 6) {

                    Spacer()

                    VStack(alignment: .trailing) {

                        Text("Status: *\(viewModel.notificationsStatus)*")

                        if viewModel.showEnableNotifications {
                            Button("Enable notifications") {
                                viewModel.enableNotificationsInSettings()
                            }
                            .buttonStyle(.menu(selected: true))
                        }

                        if viewModel.showAuthorizeNotifications {
                            Button("Authorize notifications") {
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

#Preview {
    MenuView()
}



