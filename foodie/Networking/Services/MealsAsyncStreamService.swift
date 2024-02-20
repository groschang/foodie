//
//  MealsAsyncStreamService.swift
//  foodie
//
//  Created by Konrad Groschang on 30/05/2023.
//

import Foundation

protocol MealsAsyncStreamServiceType {

    func getCategories() -> AsyncThrowingStream<Categories, Error>
    func getMeals(for category: Category) -> AsyncThrowingStream<Meals, Error>
    func getMeal(for mealId: String) -> AsyncThrowingStream<Meal, Error>
    func getRandomMeal() -> AsyncThrowingStream<Meal, Error>
}

final class MealsAsyncStreamService: MealsAsyncStreamServiceType { 
    //TODO: array with task id if the serive or action is not in progress / actor? -> screen

    private let backendClient: HTTPClient
    private let persistanceClient: PersistenceClient

    init(
        backendClient: HTTPClient = APIClient(),
        persistanceClient: PersistenceClient = CoreDataClient()
    ) {
        self.persistanceClient = persistanceClient
        self.backendClient = backendClient
    }

    // MARK: Categories

    func getCategories() -> AsyncThrowingStream<Categories, Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {
                    
                    if let persisted = await loadCategories() {
                        continuation.yield(persisted)
                    }

                    let fetched = try await fetchCategories()

                    await saveCategories(fetched)

                    continuation.yield(fetched)
                    continuation.finish()

                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }

    private func loadCategories() async -> Categories? {
        await persistanceClient.getCategories()
    }

    private func fetchCategories() async throws -> Categories {
        let request = MealDBEndpoint.CategoriesRequest()
        let categories = try await backendClient.process(request)
        return categories
    }

    private func saveCategories(_ categories: Categories) async {
        await persistanceClient.saveCategories(categories)
    }

    // MARK: Meals

    func getMeals(for category: Category) -> AsyncThrowingStream<Meals, Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {

                    if let persisted = await loadMeals(for: category) {
                        continuation.yield(persisted)
                    }

                    let fetched = try await fetchMeals(for: category)

                    await saveMeals(fetched, for: category)

                    continuation.yield(fetched)
                    continuation.finish()

                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }

    private func loadMeals(for category: Category) async -> Meals? {
        await persistanceClient.getMeals(for: category)
    }

    private func fetchMeals(for category: Category) async throws -> Meals {
        let request = MealDBEndpoint.MealsRequest(category: category.name)
        let meals = try await backendClient.process(request)
        return meals
    }

    private func saveMeals(_ meals: Meals, for category: Category) async {
        await persistanceClient.saveMeals(meals, for: category)
    }

    // MARK: Meal

    func getMeal(for mealId: String) -> AsyncThrowingStream<Meal, Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {

                    if let persisted = await loadMeal(for: mealId) {
                        continuation.yield(persisted)
                    }

                    let fetched = try await fetchMeal(for: mealId)

                    await saveMeal(fetched)

                    continuation.yield(fetched)
                    continuation.finish()

                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }

    func getRandomMeal() -> AsyncThrowingStream<Meal, Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {

                    let fetched = try await fetchRandomMeal()

                    await saveMeal(fetched)

                    continuation.yield(fetched)
                    continuation.finish()

                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }

    private func loadMeal(for mealId: String) async -> Meal? {
        await persistanceClient.getMeal(for: mealId)
    }

    private func fetchMeal(for mealId: String) async throws -> Meal {
        let request = MealDBEndpoint.MealRequest(id: mealId)
        let meal = try await backendClient.process(request)
        return meal
    }

    private func fetchRandomMeal() async throws -> Meal {
        let request = MealDBEndpoint.MealRandomRequest()
        let meal = try await backendClient.process(request)
        return meal
    }

    private func saveMeal(_ meal: Meal) async {
        await persistanceClient.saveMeal(meal)
    }

}
