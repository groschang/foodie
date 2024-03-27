//
//  AsyncViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 20/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

class AsyncViewFactory: ViewFactoryType {

    private let service: MealsAsyncServiceType

    private lazy var categoriesFactory = CategoriesAsyncViewFactory(service: service)
    private lazy var mealsFactory = MealsAsyncViewFactory(service: service)
    private lazy var mealFactory = MealAsyncViewFactory(service: service)

    private lazy var menuFactory = MenuViewFactory()

    init(service: MealsAsyncServiceType) {
        self.service = service
    }

    @MainActor @ViewBuilder
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

        case .meal(let mealCategory):
            mealFactory.makeView(item: mealCategory)

        case .menu:
            menuFactory.makeView()
        }
    }
}
