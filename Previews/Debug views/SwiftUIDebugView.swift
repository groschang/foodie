//
//  SwiftUIDebugView.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//

import SwiftUI

struct SwiftUIDebugView: View {

    var body: some View {

        List {
            // Debug app colors and styles
            
            DebugSection("Custom colors") {
                ForEach(Color.all, id: \.self) {
                    ColorDebugView($0)
                }
            }

            DebugSection("AppStyles") {
                ForEach(AppStyle.all, id: \.self) {
                    ColorStyleDebugView($0)
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
