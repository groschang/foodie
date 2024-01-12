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

    init(viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        AsyncContentView(source: viewModel, content: content)
            .navigationTitle(viewModel.title)
            .searchable(text: $viewModel.searchQuery)
    }
    
    private var content: some View {
        List(viewModel.filteredItems, selection: $category) { category in
            RouterLink(to: .meals(category)) {
                CategoryView(
                    viewModel: CategoryViewModel(category: category)
                )
            }
            .modifier(ListRowModifier())
        }
        .modifier(ListModifier())
    }
}

// MARK: Previews

struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        MocksPreview(mocks: CategoriesViewModel.mocks,
                     type: CategoriesViewModelMock.self) {
            CategoriesView(viewModel: $0)
        }
    }
}
