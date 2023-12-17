//
//  ViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 03/10/2023.
//

import SwiftUI

class ViewFactory {

    private let service: MealsServiceType
    private let asyncService: MealsServiceAsyncType

    private lazy var categoriesFactory = CategoriesViewFactory(service: service, asyncService: asyncService)
    private lazy var melasFactory = MealsViewFactory(service: service, asyncService: asyncService)
    private lazy var melaFactory = MealViewFactory(service: service, asyncService: asyncService)

    init(service: MealsServiceType,
         asyncService: MealsServiceAsyncType) {
        self.service = service
        self.asyncService = asyncService
    }

    @MainActor @ViewBuilder
    func makeView(type: Route) -> some View {
        switch type {
        case .categories:
            categoriesFactory.makeView()
        case .emptyCategories:
            categoriesFactory.makeEmptyView()
        case .meals(let category):
            melasFactory.makeView(item: category)
        case .emptyMeals:
            melasFactory.makeEmptyView()
        case .meal(let mealCategory):
            melaFactory.makeView(item: mealCategory)
        }
    }
}

// MARK: Mock

extension ViewFactory {
    static let mock = ViewFactory(service: MealsServiceMock(), asyncService: MealsServiceAsyncMock())
}
