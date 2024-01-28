//
//  IngredientsView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2024.
//

import SwiftUI

struct MealViewIngredientTitleStyle: ViewModifier {

    private struct Shadow {
        static let radius = 8.0
    }

    func body(content: Content) -> some View {
        content
            .bold()
            .modifier(TextStyle.title3)
    }
}




struct MealViewIngredientSubitleStyle: ViewModifier {

    private struct Shadow {
        static let radius = 8.0
    }

    func body(content: Content) -> some View {
        content
            .bold()
            .modifier(TextStyle.subtitle3)
    }
}




struct MealViewSourceStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .foregroundColor(.accentColor)
            .frame(maxWidth: .infinity)
    }
}


