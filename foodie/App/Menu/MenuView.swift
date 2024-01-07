//
//  MenuView.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//

import SwiftUI

struct MenuView: View {

    @ObservedObject var viewModel = MenuViewModel()

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
        }
        .padding()
        .listStyle(SidebarListStyle())
    }
}

#Preview {
    MenuView()
}



