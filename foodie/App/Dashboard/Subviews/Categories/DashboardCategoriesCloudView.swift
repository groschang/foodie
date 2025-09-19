//
//  DashboardCategoriesCloudView.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct DashboardCategoriesCloudView<ViewModel: DashboardCategoriesViewModelType>: View {

    @EnvironmentObject var router: Router

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

            Button(
                action: { router.navigate(to: .categories) },
                label: {
                    Text("See all")
                        .subtitle()
                        .foregroundStyle(AppStyle.white)
                })
        }
        .padding(.horizontal)
    }

    private var scrollView: some View {
        LazyVGrid(columns: [GridItem(.flexible(minimum: 0, maximum: .infinity)),
                            GridItem(.flexible(minimum: 0, maximum: .infinity))]) {

            ForEach(viewModel.items) { category in
                RouterLink(to: .meals(category)) {
                    DashboardCategoryView(category: category)
                }
            }
        }
    }
}

// MARK: Preview

#Preview {
    let viewModel = DashboardCategoriesViewModel.mock
    return DashboardCategoriesCloudView(viewModel: viewModel) { }
        .task { await viewModel.load() }
}
