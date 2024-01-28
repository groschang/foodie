//
//  MealInformationView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 18/05/2023.
//

import SwiftUI

struct MealInformationTitleStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .bold()
            .modifier(TextStyle.title)
    }
}




struct MealInformationSubtitleStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .italic()
            .modifier(TextStyle.title3)
    }
}
