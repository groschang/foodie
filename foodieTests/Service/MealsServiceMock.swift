//
//  MealsServiceMock.swift
//  foodieTests
//
//  Created by Konrad Groschang on 14/02/2024.
//

import Foundation
@testable import foodie

class MealsServiceMock: Sleepable, Mockable, MealsClosureServiceType {

    // MARK: Categories

    public var stubGetCategories: Result<Categories, Error>?
    public var didGetCategories: (() -> Void)?
    public var getCategoriesCallCount = 0

    func getCategories(handler: CategoriesHandler? = nil) async throws -> Categories {
        defer { didGetCategories?() }
        getCategoriesCallCount += 1
        return try stubGetCategories!.get()
    }

    // MARK: Meals

    public var stubGetMeals: Result<Meals, Error>?
    public var didGetMeals: (() -> Void)?
    public var getMealsCallCount = 0

    func getMeals(for category: foodie.Category, handler: MealsHandler? = nil) async throws -> Meals {
        defer { didGetMeals?() }
        getMealsCallCount += 1
        return try stubGetMeals!.get()
    }

    // MARK: Meal

    public var stubGetMeal: Result<Meal, Error>?
    public var didGetMeal: (() -> Void)?
    public var getMealCallCount = 0

    func getMeal(for mealId: String, handler: MealHandler? = nil) async throws -> Meal {
        defer { didGetMeal?() }
        getMealCallCount += 1
        return try stubGetMeal!.get()
    }

    public var stubRandomMeal: Result<Meal, Error>?
    public var didRandomMeal: (() -> Void)?
    public var getRandomCallCount = 0

    func getRandomMeal(handler: MealHandler?) async throws -> Meal {
        defer { didRandomMeal?() }
        getRandomCallCount += 1
        return try stubRandomMeal!.get()
    }
}
