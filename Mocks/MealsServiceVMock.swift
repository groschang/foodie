//
//  MealsServiceAsyncMock.swift
//  foodie
//
//  Created by Konrad Groschang on 10/07/2023.
//

import Foundation

class MealsServiceAsyncMock: Mockable, Sleepable, MealsServiceAsyncType {

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

    func loadCategories() async -> Categories? {
        Self.loadJSON(filename: "categories", type: Categories.self)
    }

    func fetchCategories() async throws -> Categories {
        try await sleep()
        return Self.loadJSON(filename: "categories", type: Categories.self)
    }

    func getMeals(for category: Category) async -> Meals? {
        Self.loadJSON(filename: "meals", type: Meals.self)
    }

    func fetchMeals(for category: Category) async throws -> Meals {
        try await sleep()
        return Self.loadJSON(filename: "meals", type: Meals.self)
    }

    func loadMeal(for mealId: String) async -> Meal? {
        Self.loadJSON(filename: "meal", type: Meal.self)
    }

    func fetchMeal(for mealId: String) async throws -> Meal {
        try await sleep()
        return Self.loadJSON(filename: "meal", type: Meal.self)
    }
}
