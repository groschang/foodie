//
//  TitleBackButton.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2024.
//

import SwiftUI

struct TitleBackButton: View {

    let action: VoidAction?

    var body: some View {
        Button(action: { action?() }) {
            HStack {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
                    .background(.clear)

                Text("Back")
            }
        }
        .foregroundStyle(AppStyle.white)
    }
}
