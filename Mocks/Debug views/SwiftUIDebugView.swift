//
//  SwiftUIDebugView.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//

import SwiftUI

struct SwiftUIDebugView: View {

    // AppStyles
    let appStyles = [
        AppStyle.white,
        AppStyle.lightGray,
        AppStyle.gray,
        AppStyle.darkGray,
        AppStyle.black,
        AppStyle.blue,
        AppStyle.orange,

        AppStyle.light,
        AppStyle.lightWhite,
        AppStyle.darkWhite,
        AppStyle.lightBlack,
        AppStyle.darkBlack,
        AppStyle.darkBlue,

        AppStyle.foreground,
        AppStyle.background,
        AppStyle.accent,
        AppStyle.shadow
    ]

    // Colors
    let colors: [Color] = [
        .lightGray,
        .darkGray,

        .light,
        .lightWhite,
        .darkWhite,
        .lightBlack,
        .darkBlack,
        .darkBlue,

        .foreground,
        .background,
        .accent,
        .shadow
    ]



    var body: some View {

        List {

            // Debug app colors and styles

            DebugSection("AppStyles") {
                ForEach(appStyles, id: \.self) {
                    ColorStyleDebugView($0)
                }
            }

            DebugSection("Custom colors") {
                ForEach(colors, id: \.self) {
                    ColorDebugView($0)
                }
            }

            DebugSection("Colors test") {
                ColorDebugView(color: Color.gray)
                ColorStyleDebugView(style: AppStyle.gray)
                ColorStyleDebugView(style: AppStyle.darkBlue)
                ColorStyleDebugView(style: AppStyle.shadow)
                ColorStyleDebugView(style: AppStyle.background)
                ColorStyleDebugView(style: AppStyle.blue.opacity(0.5))
                ColorStyleDebugView(style: AppStyle.darkBlue)
                ColorStyleDebugView(style: AppStyle.blue.heaviestOpacity())
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Debug")
    }
}

#Preview {
    NavigationView {
        SwiftUIDebugView()
    }
}
