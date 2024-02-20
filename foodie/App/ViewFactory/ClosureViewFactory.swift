//
//  ClosureViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 20/02/2024.
//

import SwiftUI

class ClosureViewFactory: ViewFactoryType {

    private let service: MealsClosureServiceType

    private lazy var categoriesFactory = CategoriesClosureViewFactory(service: service)
    private lazy var mealsFactory = MealsClosureViewFactory(service: service)
    private lazy var mealFactory = MealClosureViewFactory(service: service)

    private lazy var menuFactory = MenuViewFactory()

    init(service: MealsClosureServiceType) {
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
