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

            DebugSection("Colors") {
                ColorDebugView(color: Color.gray)
                ColorStyleDebugView(style: AppStyle.gray)
                ColorStyleDebugView(style: AppStyle.darkBlue)
                ColorStyleDebugView(style: AppStyle.shadow)
                ColorStyleDebugView(style: AppStyle.background)
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
