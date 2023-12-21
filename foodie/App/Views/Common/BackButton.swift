//
//  BackButton.swift
//  foodie
//
//  Created by Konrad Groschang on 15/04/2023.
//

import SwiftUI

struct BackButton: View {

    let action: VoidAction?

    var body: some View {
        Button(action: { action?() }) {
            Image(systemName: "arrow.backward")
                .imageScale(.large)
                .background(.clear)
                .foregroundStyle(AppStyle.accent)
        }
    }
}

