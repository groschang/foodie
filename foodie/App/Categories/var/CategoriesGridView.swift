//
//  CategoriesGridView.swift
//  foodie
//
//  Created by Konrad Groschang on 20/03/2023.
//

import SwiftUI

struct CategoriesGridView<Model>: View where Model: CategoriesViewModelType {

    @EnvironmentObject var router: Router
    
    @StateObject private var viewModel: Model //TODO: dont need stae obj
//    private var viewFactory: CategoriesViewFactory
    
    @State private var category: Category?
    
//    init(viewModel: Model, viewFactory: CategoriesViewFactory) {
    init(viewModel: Model) {
//        self.viewFactory = viewFactory
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationSplitView(sidebar: { sidebar },
                            detail: { detail })
    }
    
    private var sidebar: some View {
        AsyncContentView(source: viewModel, content: content)
            .navigationTitle("Meals")
//            .navigationDestination(for: Category.self) { category in
//                viewFactory.makeMealsView(category)
//            }
        //            .searchable(text: $viewModel.searchQuery)
        //            .refreshable {
        //                await viewModel.load()
        //            }
            .task {
                await viewModel.load()
            }
    }
    
    private var content: some View {
        //        List(viewModel.filteredItems, selection: $category) { category in
        //            NavigationLink(value: category) {
        //                CategoryGridItemView(category: category)
        //            }
        //            .modifier(ListRowModifier())
        //        }
        //        .modifier(ListModifier())

        ScrollView {
            Grid {


                ForEach(viewModel.filteredItems) { category in

                    GridRow {
                        NavigationLink(value: category) {
                            CategoryGridItemView(category: category)
                        }

                        NavigationLink(value: category) {
                            CategoryGridItemView(category: category)
                        }
                    }
                    //                    .modifier(ListRowModifier())
                }

            }
        }

        //        ScrollView(.vertical) {
        //            LazyVGrid(rows: rows, alignment: .center) {
        //                ForEach(viewModel.filteredItems, id: \.self) { category in
        ////                    NavigationLink(value: category) {
        //                        CategoryGridItemView(category: category)
        ////                    }
        ////                    .modifier(ListRowModifier())
        //                }
        //            }
        //            .frame(height: 150)
        //        }
    }
    
    @ViewBuilder
    private var detail: some View {
//        if let category {
//            viewFactory.makeMealsView(category)
//        } else {
//            viewFactory.makeDefaultView()
//        }
        EmptyView()
    }
}

// MARK: Styles

//struct ListModifier: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .tint(Color.blue.heavierOpacity())
//    }
//}
//
//struct ListRowModifier: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .listRowSeparator(.hidden)
//    }
//}

// MARK: Previews

struct CategoriesGridView_Previews: PreviewProvider {

    static var previews: some View {
//        CategoriesGridView(viewModel: CategoriesViewModelMock(),
//                           viewFactory: .mock)
        CategoriesGridView(viewModel: CategoriesViewModelMock())
        .previewAsScreen()
        //        CategoriesGridView(viewModel: .emptyMock, viewFactory: .mock)
        //            .previewAsScreen()
        //        CategoriesGridView(viewModel: .errorMock, viewFactory: .mock)
        //            .previewAsScreen()
        //        CategoriesGridView(viewModel: .loadingMock, viewFactory: .mock)
        //            .previewAsScreen()
        //        CategoriesGridView(viewModel: .delayedMock, viewFactory: .mock)
        //            .previewAsScreen()
    }
}
