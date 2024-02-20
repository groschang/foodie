//
//  MealsAsyncStreamServicePreview.swift
//  foodie
//
//  Created by Konrad Groschang on 14/02/2024.
//

import Foundation

class MealsAsyncStreamServicePreview: Sleepable, MealsAsyncStreamServiceType {

    func getCategories() -> AsyncThrowingStream<Categories, Error> {
        AsyncThrowingStream { continuation in
            continuation.yield(.stub)
            continuation.finish()
        }
    }

    func getMeals(for category: Category) -> AsyncThrowingStream<Meals, Error> {
        AsyncThrowingStream { continuation in
            continuation.yield(.stub)
            continuation.finish()
        }
    }

    func getMeal(for mealId: String) -> AsyncThrowingStream<Meal, Error> {
        AsyncThrowingStream { continuation in
            continuation.yield(.stub)
            continuation.finish()
        }
    }

    func getRandomMeal() -> AsyncThrowingStream<Meal, Error> {
        AsyncThrowingStream { continuation in
            continuation.yield(.stub)
            continuation.finish()
        }
    }
}
