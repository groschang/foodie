//
//  MealViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 04/10/2023.
//

import SwiftUI

class MealViewFactory: MealClosureViewFactory { }


class MealClosureViewFactory: ViewBuilderProtocol {

    private let service: MealsClosureServiceType

    init(service: MealsClosureServiceType) {
        self.service = service
    }

    @MainActor @ViewBuilder
    func makeView(item mealCategory: any IdentifiableObject) -> some View {
        let viewModel = MealViewModel(service: service, mealCategory: mealCategory)
        MealView(viewModel: viewModel)
    }

    @MainActor
    func makeEmptyView() -> some View {
        makeInformationView(message: "No meal")
    }
}


class MealAsyncViewFactory: ViewBuilderProtocol {

    private let service: MealsAsyncServiceType //TODO: 

    init(service: MealsAsyncServiceType) {
        self.service = service
    }

    @MainActor @ViewBuilder
    func makeView(item mealCategory: any IdentifiableObject) -> some View {
        let viewModel = MealAsyncViewModel(service: service, mealCategory: mealCategory)
        MealView(viewModel: viewModel)
    }

    @MainActor
    func makeEmptyView() -> some View {
        makeInformationView(message: "No meal")
    }
}


class MealAsyncStreamViewFactory: ViewBuilderProtocol {

    private let service: MealsAsyncStreamServiceType

    init(service: MealsAsyncStreamServiceType) {
        self.service = service
    }

    @MainActor @ViewBuilder
    func makeView(item mealCategory: any IdentifiableObject) -> some View {
        let viewModel = MealAsyncStreamViewModel(service: service, mealCategory: mealCategory)
        MealView(viewModel: viewModel)
    }

    @MainActor
    func makeEmptyView() -> some View {
        makeInformationView(message: "No meal")
    }
}

// MARK: Mock

extension MealViewFactory {
    static let mock = MealViewFactory(service: MealsServiceMock())
}
