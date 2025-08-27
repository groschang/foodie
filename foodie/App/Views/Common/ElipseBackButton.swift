//
//  ElipseBackButton.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
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
            .glassEffect()
        }
        .foregroundStyle(AppStyle.white)
        .buttonStyle(.growing)
    }
}


extension View {

    func eclipseBackButton(action: @escaping VoidAction) -> some View {
        overlay {
            ElipseBackButton() { action() }
                .placeAtTheTop()
                .placeAtTheLeft()
                .padding()
        }
    }
}
