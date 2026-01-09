//
//  MealsAsyncService.swift
//  foodie
//
//  Created by Konrad Groschang on 21/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

protocol MealsAsyncServiceType: Sendable {

    @concurrent func loadCategories() async -> Categories?
    @concurrent func fetchCategories() async throws -> Categories

    @concurrent func getMeals(for category: Category) async -> Meals?
    @concurrent func fetchMeals(for category: Category) async throws -> Meals

    @concurrent func loadMeal(for mealId: String) async -> Meal?
    @concurrent func fetchMeal(for mealId: String) async throws -> Meal
    @concurrent func fetchRandomMeal() async throws -> Meal
}


actor MealsAsyncService: MealsAsyncServiceType {

    private let backendClient: HTTPClient
    private let persistanceClient: PersistenceClient

    init(
        backendClient: HTTPClient = APIClient(),
        persistanceClient: PersistenceClient = CoreDataClient()
    ) {
        self.persistanceClient = persistanceClient
        self.backendClient = backendClient
    }

    //MARK: - Categories

    func loadCategories() async -> Categories? {
        await persistanceClient.getCategories()
    }

    func fetchCategories() async throws -> Categories {
        let request = MealDBEndpoint.CategoriesRequest()
        let categories = try await backendClient.process(request)

        await persistanceClient.saveCategories(categories)

        return categories
    }

    //MARK: - Meals

    func getMeals(for category: Category) async -> Meals? {
        await persistanceClient.getMeals(for: category)
    }

    func fetchMeals(for category: Category) async throws -> Meals {
        let request = MealDBEndpoint.MealsRequest(category: category.name)
        let meals = try await backendClient.process(request)

        await persistanceClient.saveMeals(meals, for: category)

        return meals
    }

    //MARK: - Meal

    func loadMeal(for mealId: String) async -> Meal? {
        Logger.thread()
        return await persistanceClient.getMeal(for: mealId)
    }

    func fetchMeal(for mealId: String) async throws -> Meal {
        let request = MealDBEndpoint.MealRequest(id: mealId)
        let meal = try await backendClient.process(request)

        await persistanceClient.saveMeal(meal)
        Logger.thread()
        return meal
    }

    func fetchRandomMeal() async throws -> Meal {
        let request = MealDBEndpoint.MealRandomRequest()
        let meal = try await backendClient.process(request)

        await persistanceClient.saveMeal(meal)

        return meal
    }

}




