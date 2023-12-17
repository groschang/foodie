//
//  MealViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 04/10/2023.
//

import SwiftUI

class MealViewFactory: ViewBuilderProtocol {

    private let service: MealsServiceType
    private let asyncService: MealsServiceAsyncType

    init(service: MealsServiceType,
         asyncService: MealsServiceAsyncType) {
        self.service = service
        self.asyncService = asyncService
    }

    @MainActor @ViewBuilder
    func makeView(item mealCategory: any IdentifiableObject) -> some View {
        let viewModel = MealViewModel(service: service, mealCaterory: mealCategory)
        MealView(viewModel: viewModel)
    }

    @MainActor
    func makeEmptyView() -> some View {
        makeInformationView(message: "No meal")
    }
}

// MARK: Mock

extension MealViewFactory {
    static let mock = MealViewFactory(service: MealsServiceMock(), asyncService: MealsServiceVMock())
}
