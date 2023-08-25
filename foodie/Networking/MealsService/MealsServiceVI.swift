//
//  MealsServiceVI.swift
//  foodie
//
//  Created by Konrad Groschang on 25/07/2023.
//

import Foundation

protocol MealsServiceVIType { //TODO: RENAM

    func loadCategories() async throws -> Categories

    func loadMeals(_ category: Category) async throws -> Meals

    func loadMeal(_ meal: Meal) async throws -> Meal
}

class MealsServiceVI: MealsServiceVIType {

    private let backendClient: HTTPClient

    private let persistanceClient: PersistenceClient

    private var activeTasks = [String: Task<Any, Error>]()


    init(
        backendClient: HTTPClient = APIClient(),
        persistanceClient: PersistenceClient = CoreDataClient()
    ) {
        self.persistanceClient = persistanceClient
        self.backendClient = backendClient
    }

    // MARK: categories

    func loadCategories() async throws -> Categories {
        try await load(itemID: Categories.Identifier,
                       load: loadStoredCategories,
                       fetch: fetchCategories)
    }

    private func loadStoredCategories() async -> Categories? {
        await persistanceClient.getCategories()
    }

    private func fetchCategories() async throws -> Categories {
        let request = MealDBEndpoint.CategoriesRequest()
        let categories = try await backendClient.process(request)

        await persistanceClient.saveCategories(categories)

        return categories
    }

    // MARK: Meals

    func loadMeals(_ category: Category) async throws -> Meals {
        try await load(item: category,
                       load: loadStoredMeals,
                       fetch: fetchMeals)
    }

    private func loadStoredMeals(_ category: Category) async -> Meals? {
        await persistanceClient.getMeals(for: category)
    }

    private func fetchMeals(_ category: Category) async throws -> Meals {
        let request = MealDBEndpoint.MealsRequest(category: category.name)
        let meals = try await backendClient.process(request)

        await persistanceClient.saveMeals(meals, for: category)

        return meals
    }

    // MARK: Meal

    func loadMeal(_ meal: Meal) async throws -> Meal {
        try await load(item: meal,
                       load: loadStoredMeal,
                       fetch: fetchMeal)
    }

    private func loadStoredMeal(_ meal: Meal) async -> Meal? {
        await persistanceClient.getMeal(for: meal.id)
    }

    private func fetchMeal(_ meal: Meal) async throws -> Meal {
        let request = MealDBEndpoint.MealRequest(id: meal.id)
        let meal = try await backendClient.process(request)

        await persistanceClient.saveMeal(meal)

        return meal
    }
}

extension MealsServiceVI {

    private func load<T>(
        itemID: String,
        load: @escaping () async -> T?,
        fetch: @escaping () async throws -> T
    ) async throws -> T {

        if let task = activeTasks[itemID] {
            return try await task.value as! T
        }

        let task = Task<Any, Error> {

            if let stored = await load() {
                activeTasks[itemID] = nil
                return stored as! Category
            }

            do {
                let items = try await fetch()

                activeTasks[itemID] = nil
                return items
            } catch {
                activeTasks[itemID] = nil
                throw error
            }
        }

        activeTasks[itemID] = task
        return try await task.value as! T
    }

    private func load<T, V: StringIdentifier>(
        item: V,
        load: @escaping (V) async -> T?,
        fetch: @escaping (V) async throws -> T
    ) async throws -> T {

        if let task = activeTasks[item.stringIdentifier] {
            return try await task.value as! T
        }

        let task = Task<Any, Error> {

            if let stored = await load(item) {
                activeTasks[item.stringIdentifier] = nil
                return stored as! Category
            }

            do {
                let items = try await fetch(item)

                activeTasks[item.stringIdentifier] = nil
                return items
            } catch {
                activeTasks[item.stringIdentifier] = nil
                throw error
            }
        }

        activeTasks[item.stringIdentifier] = task
        return try await task.value as! T
    }
}



