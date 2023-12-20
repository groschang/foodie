//
//  MealsAsyncStreamServiceMock.swift
//  foodie
//
//  Created by Konrad Groschang on 17/12/2023.
//

import Foundation

class MealsAsyncStreamServiceMock: Mockable, Sleepable, MealsAsyncStreamServiceType {

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

    private static let categories = loadJSON(filename: "categories", type: Categories.self)
    private static let meals = loadJSON(filename: "meals", type: Meals.self)
    private static let meal = loadJSON(filename: "meal", type: Meal.self)

    func getCategories() -> AsyncThrowingStream<Categories, Error> {
        AsyncThrowingStream { continuation in
            continuation.yield(Self.categories)
            continuation.finish()
        }
    }

    func getMeals(for category: Category) -> AsyncThrowingStream<Meals, Error> {
        AsyncThrowingStream { continuation in
            continuation.yield(Self.meals)
            continuation.finish()
        }
    }

    func getMeal(for mealId: String) -> AsyncThrowingStream<Meal, Error> {
        AsyncThrowingStream { continuation in
            continuation.yield(Self.meal)
            continuation.finish()
        }
    }

    func getRandomMeal() -> AsyncThrowingStream<Meal, Error> {
        AsyncThrowingStream { continuation in
            continuation.yield(Self.meal)
            continuation.finish()
        }
    }
}
