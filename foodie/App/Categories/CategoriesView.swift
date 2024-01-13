//
//  CategoriesView.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//

import SwiftUI

struct CategoriesView<Model>: View where Model: CategoriesViewModelType {

    @StateObject private var viewModel: Model //TODO: dont need stae obj

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
            if listType == .grid {
                gridContent
            } else {
                listContent
            }
        }
        .modifier(MealsViewRecipesStyle())
    }

    private var listContent: some View {

        ForEach(viewModel.filteredItems) { category in

            RouterLink(to: .meals(category)) {

                if listType == .list {

                    CategoryListView(
                        viewModel: CategoryListViewModel(category: category)
                    )

                } else if listType == .post {

                    CategoriesGridView(
                        viewModel: CategoryListViewModel(category: category)
                    )

                }
            }
            .modifier(ListRowModifier())
        }
        .modifier(ListRowModifier())
    }

    private var gridContent: some View {

        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 140))],
            spacing: 20
        ) {
            ForEach(viewModel.filteredItems) { category in

                RouterLink(to: .meals(category)) {
                    CategoriesGridView(
                        viewModel: CategoryListViewModel(category: category),
                        fontType: .small
                    )
                }
            }
        }
    }
}

// MARK: Previews

struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        MocksPreview(mocks: CategoriesViewModel.mocks,
                     type: CategoriesViewModelMock.self) { item in
            NavigationView {
                CategoriesView(viewModel: item)
            }
        }
    }
}
