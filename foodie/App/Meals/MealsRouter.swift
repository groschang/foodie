//
//  MealsRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import SwiftUI

enum MealsRouter: RouterProtocol {

    case meals(Category)

    @MainActor @ViewBuilder
    func makeView() -> some View {
        switch self {
        case .meals(let category):
            makeMealsView(category: category)
        }
    }

    @MainActor
    private func makeMealsView(category: Category) -> some View {
        let service = MealsServiceMock()
        let serviceV = MealsServiceVMock()
        let viewModel = MealsAsyncViewModel(service: serviceV, category: category)
        let viewFactory = MealsViewFactory(service: service)
        return MealsView(viewModel: viewModel, viewFactory: viewFactory)
    }
}
