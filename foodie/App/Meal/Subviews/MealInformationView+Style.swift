//
//  MealInformationView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 18/05/2023.
//

import SwiftUI

struct MealInformationViewStyle: ViewModifier {

    private struct Shadow {
        static let radius = 4.0
    }

    func body(content: Content) -> some View {
        content
            .shadow(radius: Shadow.radius)
    }
}

struct MealInformationTitleStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.title) //TODO: title style  #text
            .bold()
    }
}

struct MealInformationSubtitleStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.title3) //TODO: title style  #text
            .italic()
    }
}
