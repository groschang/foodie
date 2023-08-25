//
//  CoreDataClientMock.swift
//  foodieTests
//
//  Created by Konrad Groschang on 27/07/2023.
//

import Foundation
@testable import foodie

public final class CoreDataClientMock: PersistenceClient {

    public var stubGetCategoriesResponse: Categories?
    public var didGetCategories: (() -> Void)?
    public var getCategoriesCallCount = 0

    public func getCategories() async -> Categories? {
        defer { didGetCategories?() }
        getCategoriesCallCount += 1
        return stubGetCategoriesResponse
    }

    var didSaveCategories: (() -> Void)?
    var saveCategoriesCallCount = 0

    public func saveCategories(_ categories: Categories) async {
        defer { didSaveCategories?() }
        saveCategoriesCallCount += 1
    }

    public var stubGetMealResponse: Meal?
    public var didGetMeal: (() -> Void)?
    public var getMealCallCount = 0

    public func getMeal(for mealId: String) async -> Meal? {
        defer { didGetMeal?() }
        getMealCallCount += 1
        return stubGetMealResponse
    }

    public var didSaveMeal: (() -> Void)?
    public var saveMealCallCount = 0

    public func saveMeal(_ meal: Meal) async {
        defer { didSaveMeal?() }
        saveMealCallCount += 1
    }

    public var stubGetMealsResponse: Meals?
    public var didGetMeals: (() -> Void)?
    public var getMealsCallCount = 0

    public func getMeals(for category: foodie.Category) async -> Meals? {
        defer { didGetMeals?() }
        getMealsCallCount += 1
        return stubGetMealsResponse
    }

    public var didSaveMeals: (() -> Void)?
    public var saveMealsCallCount = 0

    public func saveMeals(_ meals: Meals, for category: foodie.Category) async {
        defer { didSaveMeals?() }
        saveMealsCallCount += 1
    }
}
