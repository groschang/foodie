//
//  CategoriesPosts.swift
//  foodie
//
//  Created by Konrad Groschang on 20/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct CategoriesPosts: View {

    let items: [Category]

    var body: some View {
        ForEach(items) { category in
            RouterLink(to: .meals(category)) {
                CategoryPostItem(
                    viewModel: CategoryItemViewModel(category: category)
                )
            }
        }
        .modifier(ListRowModifier())
    }
}

// MARK: - Preview

#Preview {
    CategoriesPosts(items: Categories.stub.items)
}
