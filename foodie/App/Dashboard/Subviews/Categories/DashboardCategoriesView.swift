//
//  DashboardCategoriesView.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import SwiftUI

struct DashboardCategoriesView<ViewModel: DashboardCategoriesViewModelType>: View {

    @StateObject private var viewModel: ViewModel

    private var action: () -> Void

    init(viewModel: ViewModel, action: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.action = action
    }

    var body: some View {
        VStack(alignment: .leading) {
            title
            scrollView
        }
    }

    private var title: some View {
        HStack {
            Text("Category")
                .title2()

            Spacer()

            NavigationLink(value: CategoriesRouter.categories) {
                Text("See all")
                    .subtitle()
            }
        }
        .padding(.horizontal)
    }

    private var scrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.items) { category in
                    NavigationLink(value: MealsRouter.meals(category)) {
                        DashboardCategoryVerticalView(category: category)
                    }
                }
            }
            .fixedSize()
            .padding(.horizontal)
        }
    }
}

// MARK: Preview

struct DashboardCategoriesView_Previews: PreviewProvider {

    static let viewModel = DashboardCategoriesViewModel.mock

    static var previews: some View {
        DashboardCategoriesView(viewModel: viewModel) { }
            .task { await viewModel.load() }
    }
}
