//
//  MealsService.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//

import Foundation

protocol MealsServiceType {
    typealias CategoriesHandler = (Categories) -> Void
    typealias MealsHandler = (Meals) -> Void
    typealias MealHandler = (Meal) -> Void

    func getCategories(handler: CategoriesHandler?) async throws -> Categories
    func getMeals(for category: Category, handler: MealsHandler?) async throws -> Meals
    func getMeal(for mealId: String, handler: MealHandler?) async throws -> Meal
}

actor MealsService: MealsServiceType { //TODO: ACTOR? RENAME

    let backendClient: HTTPClient
    let persistance: PersistenceClient

    init(
        backendClient: HTTPClient = APIClient(),
        persistanceClient: PersistenceClient = CoreDataClient()
    ) {
        self.persistance = persistanceClient
        self.backendClient = backendClient
    }

    func getCategories(handler: CategoriesHandler? = nil) async throws -> Categories {

        if let handler, let categories = await persistance.getCategories() {
            MainActor.runTask { handler(categories) }
        }

        let request = MealDBEndpoint.CategoriesRequest()
        let categories = try await backendClient.process(request)

        await persistance.saveCategories(categories)

        return categories
    }

    func getMeals(for category: Category, handler: MealsHandler? = nil) async throws -> Meals {

        if let handler, let meals = await persistance.getMeals(for: category) {
            MainActor.runTask { handler(meals) }
        }

        let request = MealDBEndpoint.MealsRequest(category: category.name)
        let meals = try await backendClient.process(request)

        await persistance.saveMeals(meals, for: category)

        return meals
    }

    func getMeal(for mealId: String, handler: MealHandler? = nil) async throws -> Meal {

        if let handler, let meals = await persistance.getMeal(for: mealId) {
            MainActor.runTask { handler(meals) }
        }

        let request = MealDBEndpoint.MealRequest(id: mealId)
        let meal = try await backendClient.process(request)

        await persistance.saveMeal(meal)

        return meal
    }
}

