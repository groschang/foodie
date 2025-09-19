//
//  DashboardMealsView.swift
//  foodie
//
//  Created by Konrad Groschang on 09/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct DashboardMealsView<ViewModel: DashboardMealsViewModelType>: View {

    @EnvironmentObject var router: Router

    @StateObject private var viewModel: ViewModel


    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            title
            scrollView
        }
    }

    private var title: some View {
        HStack {

            Text("Selected meals")
                .title2() //TODO: #font
                .foregroundStyle(Color.gray)

            Spacer()
        }
        .padding(.horizontal)
    }


    private var scrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {

            HStack(alignment: .top, spacing: 14) {
                ForEach(viewModel.items) { meal in
                    RouterLink(to: .meal(meal)) {

                        DashboardMealView(meal: meal)
                            .padding(.top)
                            .maxHeight()
                            .fixedSize(
                                horizontal: false,
                                vertical: true
                            )

                    }
                }
            }
            .padding(.horizontal)
        }
    }
}


// MARK: Preview

#Preview {
    let viewModel = DashboardMealsViewModel.mock
    return DashboardMealsView(viewModel: viewModel)
        .task { await viewModel.load() }
}
