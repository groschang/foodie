//
//  ElipseBackButton.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2024.
//

import SwiftUI

struct ElipseBackButton: View {

    let action: VoidAction?

    var body: some View {

        Button(action: { action?() }) {
            HStack {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
                    .background(.clear)
            }
            .padding()
            .background {
                Capsule()
                    .foregroundColor(.black)
                    .opacity(0.2)
            }
        }
        .buttonStyle(.growing)
        .foregroundStyle(AppStyle.white)
    }
}
