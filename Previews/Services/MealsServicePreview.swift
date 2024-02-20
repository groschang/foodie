//
//  MealsServicePreview.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//

import Foundation

// Stub

class MealsServicePreview: Sleepable, MealsClosureServiceType {

    func getCategories(handler: CategoriesHandler? = nil) async throws -> Categories {
        await sleep()
        return .stub
    }

    func getMeals(for category: Category, handler: MealsHandler? = nil) async throws -> Meals {
        await sleep()
        return .stub
    }

    func getMeal(for mealId: String, handler: MealHandler? = nil) async throws -> Meal {
        await sleep()
        return .stub
    }

    func getRandomMeal(handler: MealHandler?) async throws -> Meal {
        await sleep()
        return .stub
    }
}
