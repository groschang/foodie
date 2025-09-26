//
//  MealViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 04/10/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

class MealViewFactory: MealAsyncViewFactory { }


@MainActor
class MealClosureViewFactory: ViewBuilderProtocol {

    private let service: MealsClosureServiceType

    init(service: MealsClosureServiceType) {
        self.service = service
    }

    @ViewBuilder
    func makeView(item mealCategory: any IdentifiableObject) -> some View {
        let viewModel = MealViewModel(service: service, object: mealCategory)
        MealView(viewModel: viewModel)
    }

    func makeEmptyView() -> some View {
        makeInformationView(message: "No meal")
    }
}


@MainActor
class MealAsyncViewFactory: ViewBuilderProtocol {

    private let service: MealsAsyncServiceType

    init(service: MealsAsyncServiceType) {
        self.service = service
    }

    @ViewBuilder
    func makeView(item mealCategory: any IdentifiableObject) -> some View {
        let viewModel = MealAsyncViewModel(service: service, object: mealCategory)
        MealView(viewModel: viewModel)
    }

    func makeEmptyView() -> some View {
        makeInformationView(message: "No meal")
    }
}


@MainActor
class MealAsyncStreamViewFactory: ViewBuilderProtocol {

    private let service: MealsAsyncStreamServiceType

    init(service: MealsAsyncStreamServiceType) {
        self.service = service
    }

    @ViewBuilder
    func makeView(item object: any IdentifiableObject) -> some View {
        let viewModel = MealAsyncStreamViewModel(service: service, object: object)
        MealView(viewModel: viewModel)
    }

    func makeEmptyView() -> some View {
        makeInformationView(message: "No meal")
    }
}

// MARK: - Mock

extension MealViewFactory {
   @MainActor static let mock = MealViewFactory(service: MealsAsyncServicePreview())
}
