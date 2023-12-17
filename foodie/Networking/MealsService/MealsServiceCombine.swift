//
//  MealsServiceCombine.swift
//  foodie
//
//  Created by Konrad Groschang on 07/08/2023.
//

import Combine

protocol MealsServiceCombineType { //TODO: Rename MealsCombineService
    func getCategories() -> AnyPublisher<Categories?, Error>
    func getMeals(for category: Category) -> AnyPublisher<Meals?, Error>
    func getMeal(for mealId: String) -> AnyPublisher<Meal?, Error>
}

class MealsServiceCombine: MealsServiceCombineType {

    typealias CategoriesSubject = CurrentValueSubject<Categories?, Error>
    typealias MealsSubject = CurrentValueSubject<Meals?, Error>
    typealias MealSubject = CurrentValueSubject<Meal?, Error>

    private let backendClient: HTTPClient
    private let persistanceClient: PersistenceClient

    init(
        backendClient: HTTPClient = APIClient(),
        persistanceClient: PersistenceClient = CoreDataClient()
    ) {
        self.persistanceClient = persistanceClient
        self.backendClient = backendClient
    }

    //MARK: Categories

    func getCategories() -> AnyPublisher<Categories?, Error> {
        let subject = CategoriesSubject(nil)

        Task { //TODO: Put some logic here
            await loadCategories(subject: subject)
            await fetchCategories(subject: subject)
        }

        return subject.eraseToAnyPublisher()
    }

    private func loadCategories(subject: CategoriesSubject) async {
        if let persisted = await persistanceClient.getCategories() {
            subject.send(persisted)
        }
    }

    private func fetchCategories(subject: CategoriesSubject) async {
        do {
            let request = MealDBEndpoint.CategoriesRequest()
            let categories = try await backendClient.process(request)
            subject.send(categories)

            await persistanceClient.saveCategories(categories)
        } catch {
            subject.send(completion: .failure(error))
        }
    }

    //MARK: Meals

    func getMeals(for category: Category) -> AnyPublisher<Meals?, Error> {
        let subject = MealsSubject(nil)

        Task {
            await loadMeals(for: category, subject: subject)
            await fetchMeals(for: category, subject: subject)
        }

        return subject.eraseToAnyPublisher()
    }

    private func loadMeals(for category: Category, subject: MealsSubject) async {
        if let persisted = await persistanceClient.getMeals(for: category) {
            subject.send(persisted)
        }
    }

    private func fetchMeals(for category: Category, subject: MealsSubject) async {
        do {
            let request = MealDBEndpoint.MealsRequest(category: category.name)
            let meals = try await backendClient.process(request)
            subject.send(meals)

            await persistanceClient.saveMeals(meals, for: category)
        } catch {
            subject.send(completion: .failure(error))
        }
    }

    //MARK: Meal

    func getMeal(for mealId: String) -> AnyPublisher<Meal?, Error> {
        let subject = MealSubject(nil)

        Task {
            await loadMeal(for: mealId, subject: subject)
            await fetchMeal(for: mealId, subject: subject)
        }

        return subject.eraseToAnyPublisher()
    }

    private func loadMeal(for mealId: String, subject: MealSubject) async {
        if let meal = await persistanceClient.getMeal(for: mealId) {
            subject.send(meal)
        }
    }

    private func fetchMeal(for mealId: String, subject: MealSubject) async {
        do {
            let request = MealDBEndpoint.MealRequest(id: mealId)
            let meal = try await backendClient.process(request)
            subject.send(meal)

            await persistanceClient.saveMeal(meal)
        } catch {
            subject.send(completion: .failure(error))
        }
    }
}





