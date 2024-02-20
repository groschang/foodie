//
//  MealsGrid.swift
//  foodie
//
//  Created by Konrad Groschang on 20/02/2024.
//

import SwiftUI

struct MealsGrid: View {

    let items: [MealCategory]

    var body: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 140))],
            spacing: 20
        ) {
            ForEach(items) { meal in
                RouterLink(to: .meal(meal)) {
                    MealGridItem(
                        meal: meal,
                        fontType: .small
                    )
                }
            }
        }
        .padding(.horizontal)
    }
}
