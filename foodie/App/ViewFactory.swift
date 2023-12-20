//
//  ViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 03/10/2023.
//

import SwiftUI

protocol ViewFactoryType {
    associatedtype V : View
    func makeView(type: Route) -> V
}


class ViewFactory: StreamViewFactory { }


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


class StreamViewFactory: ViewFactoryType {

    private let service: MealsAsyncStreamServiceType

    private lazy var categoriesFactory = CategoriesAsyncStreamViewFactory(service: service)
    private lazy var mealsFactory = MealsAsyncStreamViewFactory(service: service)
    private lazy var mealFactory = MealAsyncStreamViewFactory(service: service)
    
    private lazy var menuFactory = MenuViewFactory()

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

        case .meal(let meal):
            mealFactory.makeView(item: meal)

        case .menu:
            menuFactory.makeView()
        }
    }
}

// MARK: Mock

extension ViewFactory {
    static let mock = ClosureViewFactory(service: MealsServiceMock()) //TODO:
}
