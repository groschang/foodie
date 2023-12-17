//
//  MealsServiceMock.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//

import Foundation

class MealsServiceMock: Mockable, Sleepable, MealsServiceType {

    enum Timing {
        static let delay = Duration.seconds(4)
    }

    let delayDuration: Duration?

    init(delayDuration: Duration? = nil) {
        self.delayDuration = delayDuration
    }

    convenience init(delay: Bool) {
        let duration = delay ? Timing.delay : .zero
        self.init(delayDuration: duration)
    }

    func getCategories(handler: CategoriesHandler? = nil) async throws -> Categories {
        try await sleep()
        return Self.loadJSON(filename: "categories", type: Categories.self)
    }

    func getMeals(for category: Category, handler: MealsHandler? = nil) async throws -> Meals {
        try await sleep()
        return Self.loadJSON(filename: "meals", type: Meals.self)
    }

    func getMeal(for mealId: String, handler: MealHandler? = nil) async throws -> Meal {
        try await sleep()
        return Self.loadJSON(filename: "meal", type: Meal.self) //TODO: MealDetail.mock ?
    }
}
