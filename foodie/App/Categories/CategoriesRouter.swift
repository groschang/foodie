//
//  CategoriesRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import SwiftUI

enum CategoriesRouter: RouterProtocol {

    case categories

    case empty

    @MainActor @ViewBuilder
    func makeView() -> some View {
        switch self {
        case .categories:
            makeCategoriesView()
        case .empty:
            makeEmptyView()
        }
    }

    @MainActor
    private func makeCategoriesView() -> some View {
        let service = MealsServiceMock()
        let serviceV = MealsServiceVMock()
        let viewModel = CategoriesViewModel(service: serviceV)
        let viewFactory = CategoriesViewFactory(service: service)
        return CategoriesView(viewModel: viewModel, viewFactory: viewFactory)
    }

    @MainActor
    private func makeEmptyView() -> some View {
        InformationView(message: "Select category")
            .ignoresSafeArea()
    }
}
