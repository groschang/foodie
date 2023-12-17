//
//  CategoriesRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import SwiftUI

enum CategoriesRouter: RouterProtocol {

    static let service = MealsServiceMock()
    static let serviceV = MealsServiceVMock()

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

    @MainActor @ViewBuilder
    private func makeCategoriesView() -> some View {
        let service = MealsServiceMock()
        let serviceV = MealsServiceVMock()
        let viewModel = CategoriesViewModel(service: serviceV)
        CategoriesView(viewModel: viewModel)
    }

    @MainActor
    private func makeEmptyView() -> some View {
        InformationView("Select category")
            .ignoresSafeArea()
    }
}
