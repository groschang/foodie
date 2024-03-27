//
//  MealsList.swift
//  foodie
//
//  Created by Konrad Groschang on 20/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct MealsList: View {

    let items: [MealCategory]

    var body: some View {
        ForEach(items) { meal in
            RouterLink(to: .meal(meal)) {
                MealListItem(meal: meal)
            }
        }
        .modifier(ListRowModifier())

    }
}
