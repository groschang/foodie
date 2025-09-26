//
//  StreamViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 20/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

@MainActor
class StreamViewFactory: ViewFactoryType {

    private let service: MealsAsyncStreamServiceType

    private lazy var categoriesFactory = CategoriesAsyncStreamViewFactory(service: service)
    private lazy var mealsFactory = MealsAsyncStreamViewFactory(service: service)
    private lazy var mealFactory = MealAsyncStreamViewFactory(service: service)

    private lazy var menuFactory = MenuViewFactory()

    init(service: MealsAsyncStreamServiceType) {
        self.service = service
    }

    @ViewBuilder
    func makeView(type: Route) -> some View {
        switch type {

        case .categories:
            categoriesFactory.makeView()
        case .emptyCategories:
            categoriesFactory.makeEmptyView()

        case .meals(let category):
            mealsFactory.makeView(item: category)
        case .emptyMeals:
            mealsFactory.makeEmptyView()

        case .meal(let meal):
            mealFactory.makeView(item: meal)

        case .menu:
            menuFactory.makeView()
        }
    }
}
