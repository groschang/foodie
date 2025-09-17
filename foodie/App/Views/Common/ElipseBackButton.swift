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
            if #available(iOS 26.0, *) {
                Label("Back arrow", systemImage: "chevron.backward")
                    .labelStyle(.iconOnly)
                    .imageScale(.large)
                    .frame(width: 36, height: 36)
                    .foregroundColor(AppStyle.black.color)
            } else {
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
                .buttonStyle(.growing)
                .foregroundStyle(AppStyle.white)
            }
        }
        .modifier(ElipseBackButtonGlassyStyle())
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
