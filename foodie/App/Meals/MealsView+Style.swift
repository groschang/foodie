//
//  MealsView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//

import SwiftUI

struct MealsViewRecipesStyle: ViewModifier {

    private struct Colors {
        static let background = ColorStyle.background.mediumOpacity()
    }

    func body(content: Content) -> some View {
        content
            .modifier(ListModifier())
            .background(ColorStyle.background)
    }
}


struct MealsViewDescriptionStyle: ViewModifier {

    private struct Layouts {
        static let height = 50.0
    }

    func body(content: Content) -> some View {
        content
            .frame(minHeight: Layouts.height)
            .modifier(ListStyle())
            .listRowInsets(ListStyle.textInserts)
    }
}


struct MealsViewHeaderStyle: ViewModifier {

    private struct Offsets {
        static let y = 60.0
    }

    func body(content: Content) -> some View {
        content
            .offset(y: Offsets.y)
            .edgesIgnoringSafeArea(.top)
    }
}


