//
//  ViewSizeModifier.swift
//  foodie
//
//  Created by Konrad Groschang on 05/09/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct ViewSizeModifier: ViewModifier {

    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            size = proxy.size
                        }
                }
            )
    }
}

extension View {
    func size(in size: Binding<CGSize>) -> ModifiedContent<Self, ViewSizeModifier> {
        modifier(ViewSizeModifier(size: size))
    }
}

