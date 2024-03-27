//
//  MealsSelectView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 17/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct MealsSelectStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .maxSize()
            .background { AnimatedGradient() }
    }
}


struct MealsSelectTitleStyle: ViewModifier {

    private struct Colors {
        static let foreground = AppStyle.lightBlack
    }

    func body(content: Content) -> some View {
        content
            .font(.system(.largeTitle, design: .monospaced)) //TODO: #font
            .foregroundStyle(Colors.foreground)
    }
}
