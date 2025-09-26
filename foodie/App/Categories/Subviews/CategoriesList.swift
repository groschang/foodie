//
//  CategoriesList.swift
//  foodie
//
//  Created by Konrad Groschang on 20/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct CategoriesList: View {

    let items: [Category]

    var body: some View {
        ForEach(items) { category in
            RouterLink(to: .meals(category)) {
                CategoryListItem(
                    viewModel: CategoryItemViewModel(category: category)
                )
            }
        }
        .modifier(ListRowModifier())
    }
}

// MARK: - Preview

#Preview {
    CategoriesList(items: Categories.stub.items)
}
