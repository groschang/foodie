//
//  CategoriesView.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct CategoriesView<Model>: View where Model: CategoriesViewModelType {

    @Environment(\.dismiss) var dismiss

    @StateObject private var viewModel: Model

    @State private var category: Category?

    @State private var listType: ListType = .grid

    init(viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        AsyncContentView(source: viewModel, content: content)
            .hideNavigationBar()
            .attachEnvironmentOverrides()
    }

    private var content: some View {
        VStack(spacing: .zero) {
            header
            categories
        }
        .background(AppStyle.background)
    }

    private var header: some View {
        ListHeader(title: viewModel.title,
                   listType: $listType,
                   dismissAction: { dismiss() })
    }

    @ViewBuilder
    private var categories: some View {
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
        .modifier(CategoriesViewListStyle())
    }

}

// MARK: - Previews

#Preview {
    NavigationView {
        CategoriesView(viewModel: CategoriesAsyncViewModel.mock)
    }
}
