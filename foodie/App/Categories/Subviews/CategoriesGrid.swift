//
//  CategoriesGrid.swift
//  foodie
//
//  Created by Konrad Groschang on 20/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct CategoriesGrid: View {

    let items: [Category]

    var body: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 140))],
            spacing: 20
        ) {
            ForEach(items) { category in
                RouterLink(to: .meals(category)) {
                    CategoryGridItem(
                        viewModel: CategoryListItemModel(category: category),
                        fontType: .small
                    )
                }
            }
        }
        .padding(.horizontal)
    }
}
