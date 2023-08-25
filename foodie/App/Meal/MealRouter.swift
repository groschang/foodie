//
//  MealRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import SwiftUI

enum MealRouter: RouterProtocol {

    case meal(MealCategory)

    @MainActor @ViewBuilder
    func makeView() -> some View {
        switch self {
        case .meal(let meal):
            makeMealView(meal: meal)
        }
    }

    @MainActor
    private func makeMealView(meal: MealCategory) -> some View {
        let service = MealsServiceMock()
        let viewModel = MealViewModel(service: service, mealCaterory: meal)
        return MealView(viewModel: viewModel)
    }
}
