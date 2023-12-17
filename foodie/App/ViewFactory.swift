//
//  ViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 03/10/2023.
//

import SwiftUI

class ViewFactory: ClosureViewFactory { }

class ClosureViewFactory {

    private(set) var service: MealsClosureServiceType

    private(set) lazy var categoriesFactory = CategoriesClosureViewFactory(service: service)
    private(set) lazy var mealsFactory = MealsClosureViewFactory(service: service)
    private(set) lazy var mealFactory = MealClosureViewFactory(service: service)

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
        }
    }
}

class AsyncViewFactory {

    private let service: MealsAsyncServiceType

    private lazy var categoriesFactory = CategoriesAsyncViewFactory(service: service)
    private lazy var mealsFactory = MealsAsyncViewFactory(service: service)
    private lazy var mealFactory = MealAsyncViewFactory(service: service)

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
        }
    }
}


class StreamViewFactory {

    private let service: MealsAsyncStreamServiceType

    private lazy var categoriesFactory = CategoriesAsyncStreamViewFactory(service: service)
    private lazy var mealsFactory = MealsAsyncStreamViewFactory(service: service)
    private lazy var mealFactory = MealAsyncStreamViewFactory(service: service)

    init(service: MealsAsyncStreamServiceType) {
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
        }
    }
}

// MARK: Mock

extension ViewFactory {
    static let mock = ViewFactory(service: MealsServiceMock())
}
