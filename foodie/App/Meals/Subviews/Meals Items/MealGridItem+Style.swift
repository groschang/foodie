//
//  MealGridItem+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 9/17/25.
//

import SwiftUI

struct MealGridItemGlassyBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content.glassEffect(
                .regular.tint(.black.heavyOpacity()),
                in: .rect(cornerRadius: MealListItemStyle.Layouts.radius, )
            )
        } else {
            content
        }
    }
}
