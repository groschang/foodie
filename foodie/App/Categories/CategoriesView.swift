//
//  CategoriesView.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//

import SwiftUI

struct CategoriesView<Model>: View where Model: CategoriesViewModelType {
    
    @StateObject private var viewModel: Model //TODO: dont need stae obj
    private var viewFactory: CategoriesViewFactory
    
    @State private var category: Category?
    
    init(viewModel: Model, viewFactory: CategoriesViewFactory) {
        self.viewFactory = viewFactory
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
//        NavigationSplitView(sidebar: { sidebar },
//                            detail: { detail })
        sidebar
    }
    
    private var sidebar: some View {
        AsyncContentView(source: viewModel, content: content)
            .navigationTitle(viewModel.title)
//            .navigationDestination(for: Category.self) { category in
//                viewFactory.makeMealsView(category)
//            }
            .searchable(text: $viewModel.searchQuery)
    }
    
    private var content: some View {
        List(viewModel.filteredItems, selection: $category) { category in
            ZStack {
                NavigationLink(value: MealsRouter.meals(category)) {
                    EmptyView()
                }

                CategoryView(
                    viewModel: CategoryViewModel(category: category)
                )
            }
            .modifier(ListRowModifier())
            
        }
        .modifier(ListModifier())
    }
    
//    @ViewBuilder
//    private var detail: some View { //TODO: check
//        if let category {
//            viewFactory.makeMealsView(category)
//        } else {
//            viewFactory.makeDefaultView()
//        }
//    }
}

// MARK: Previews

struct CategoriesListView_Previews: PreviewProvider {

    static var previews: some View {
        MocksPreview(mocks: CategoriesViewModel.mocks, viewModelType: CategoriesViewModelMock.self) {
            CategoriesView(viewModel: $0, viewFactory: .mock)
        }
    }
}
