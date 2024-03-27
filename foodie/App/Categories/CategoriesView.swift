//
//  CategoriesView.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct CategoriesView<Model>: View where Model: CategoriesViewModelType {

    @StateObject private var viewModel: Model

    @State private var category: Category?

    @State private var listType: ListType = .grid

    init(viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        AsyncContentView(source: viewModel, content: content)
            .styleNavigationBar()
            .navigationTitle(viewModel.title)
            .searchable(text: $viewModel.searchQuery)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ListTypeButton(
                        type: listType,
                        action: {
                            withAnimation {
                                listType = listType.next()
                            }
                        }
                    )
                    .tint(.accent)
                }
            }
    }

    @ViewBuilder
    private var content: some View {
        List(selection: $category) {

            let items = viewModel.filteredItems

            switch listType {
            case .list:
                CategoriesList(items: items)
            case .post:
                CategoriesPosts(items: items)
            case .grid:
                CategoriesGrid(items: items)
            }

        }
        .modifier(MealsViewRecipesStyle())
    }

}

// MARK: Previews

#Preview {
    NavigationView {
        CategoriesView(viewModel: CategoriesViewModel.stub)
    }
}
