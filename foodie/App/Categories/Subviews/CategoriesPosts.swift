//
//  CategoriesPosts.swift
//  foodie
//
//  Created by Konrad Groschang on 20/02/2024.
//

import SwiftUI

struct CategoriesPosts: View {

    let items: [Category]

    var body: some View {
        ForEach(items) { category in
            RouterLink(to: .meals(category)) {
                CategoryListItem(
                    viewModel: CategoryListItemModel(category: category)
                )
            }
        }
        .modifier(ListRowModifier())

    }
}
