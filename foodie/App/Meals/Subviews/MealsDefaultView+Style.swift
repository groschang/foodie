//
//  MealsSelectView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 17/05/2023.
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
        static let foreground = ColorStyle.black.lightOpacity()
    }

    func body(content: Content) -> some View {
        content
            .font(.system(.largeTitle, design: .monospaced)) //TODO: #font
            .foregroundColor(Colors.foreground)
    }
}
