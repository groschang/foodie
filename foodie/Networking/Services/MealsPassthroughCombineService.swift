//
//  MealsPassthroughCombineService.swift
//  foodie
//
//  Created by Konrad Groschang on 15/04/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Combine

protocol MealsPassthroughCombineServiceType {

    typealias CategoriesSubject = CurrentValueSubject<Categories?, Error>
    typealias MealsSubject = CurrentValueSubject<Meals?, Error>
    typealias MealSubject = CurrentValueSubject<Meal?, Error>

    func loadCategories(subject: CategoriesSubject) async
    func fetchCategories(subject: CategoriesSubject) async

    func loadMeals(for category: Category, subject: MealsSubject) async
    func fetchMeals(for category: Category, subject: MealsSubject) async

    func loadMeal(for mealId: String, subject: MealSubject) async
    func fetchMeal(for mealId: String, subject: MealSubject) async
}

actor MealsPassthroughCombineService: MealsPassthroughCombineServiceType {

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

    // MARK: Categories

    func loadCategories(subject: CategoriesSubject) async {
        if let persisted = await persistanceClient.getCategories() {
            subject.send(persisted)
        }
    }

    func fetchCategories(subject: CategoriesSubject) async {
        do {
            let request = MealDBEndpoint.CategoriesRequest()
            let categories = try await backendClient.process(request)
            subject.send(categories)

            await persistanceClient.saveCategories(categories)
        } catch {
            subject.send(completion: .failure(error))
        }
    }
    
    // MARK: Meals

    func loadMeals(for category: Category, subject: MealsSubject) async {
        if let persisted = await persistanceClient.getMeals(for: category) {
            subject.send(persisted)
        }
    }

    func fetchMeals(for category: Category, subject: MealsSubject) async {
        do {
            let request = MealDBEndpoint.MealsRequest(category: category.name)
            let meals = try await backendClient.process(request)
            subject.send(meals)

            await persistanceClient.saveMeals(meals, for: category)
        } catch {
            subject.send(completion: .failure(error))
        }
    }

    // MARK: Meal

    func loadMeal(for mealId: String, subject: MealSubject) async {
        if let meal = await persistanceClient.getMeal(for: mealId) {
            subject.send(meal)
        }
    }

    func fetchMeal(for mealId: String, subject: MealSubject) async {
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
