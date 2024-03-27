//
//  MealsAsyncServiceMock.swift
//  foodieTests
//
//  Created by Konrad Groschang on 14/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
@testable import foodie

class MealsAsyncServiceMock: MealsAsyncServiceType {

    init(
        stubLoadCategories: Categories? = .stub,
        didLoadCategories: ( () -> Void)? = nil,
        loadCategoriesCallCount: Int = 0,
        stubFetchCategories: Result<Categories, Error>? = .success(.stub),
        didFetchCategories: ( () -> Void)? = nil,
        fetchCategoriesCallCount: Int = 0,
        stubGetMeals: Meals? = .stub,
        didGetMeals: ( () -> Void)? = nil,
        getMealsCallCount: Int = 0,
        stubFetchMeals: Result<Meals, Error>? = .success(.stub),
        didFetchMeals: ( () -> Void)? = nil,
        fetchMealsCallCount: Int = 0,
        stubLoadMeal: Meal? = .stub,
        didLoadMeal: ( () -> Void)? = nil,
        loadMealCallCount: Int = 0,
        stubFetchMeal: Result<Meal, Error>? = .success(.stub),
        didFetchMeal: ( () -> Void)? = nil,
        fetchMealCallCount: Int = 0,
        stubFetchRandomMeal: Result<Meal, Error>? = .success(.stub),
        didFetchRandomMeal: ( () -> Void)? = nil,
        fetchRandomMealCallCount: Int = 0
    ) {
        self.stubLoadCategories = stubLoadCategories
        self.didLoadCategories = didLoadCategories
        self.loadCategoriesCallCount = loadCategoriesCallCount
        self.stubFetchCategories = stubFetchCategories
        self.didFetchCategories = didFetchCategories
        self.fetchCategoriesCallCount = fetchCategoriesCallCount
        self.stubGetMeals = stubGetMeals
        self.didGetMeals = didGetMeals
        self.getMealsCallCount = getMealsCallCount
        self.stubFetchMeals = stubFetchMeals
        self.didFetchMeals = didFetchMeals
        self.fetchMealsCallCount = fetchMealsCallCount
        self.stubLoadMeal = stubLoadMeal
        self.didLoadMeal = didLoadMeal
        self.loadMealCallCount = loadMealCallCount
        self.stubFetchMeal = stubFetchMeal
        self.didFetchMeal = didFetchMeal
        self.fetchMealCallCount = fetchMealCallCount
        self.stubFetchRandomMeal = stubFetchRandomMeal
        self.didFetchRandomMeal = didFetchRandomMeal
        self.fetchRandomMealCallCount = fetchRandomMealCallCount
    }

    public var stubLoadCategories: Categories?
    public var didLoadCategories: (() -> Void)?
    public var loadCategoriesCallCount = 0

    func loadCategories() async -> Categories? {
        defer { didLoadCategories?() }
        loadCategoriesCallCount += 1
        return stubLoadCategories!
    }

    public var stubFetchCategories: Result<Categories, Error>?
    public var didFetchCategories: (() -> Void)?
    public var fetchCategoriesCallCount = 0

    func fetchCategories() async throws -> Categories {
        defer { didFetchCategories?() }
        fetchCategoriesCallCount += 1
        return try stubFetchCategories!.get()
    }

    public var stubGetMeals: Meals?
    public var didGetMeals: (() -> Void)?
    public var getMealsCallCount = 0

    func getMeals(for category: foodie.Category) async -> Meals? {
        defer { didGetMeals?() }
        getMealsCallCount += 1
        return stubGetMeals!
    }

    public var stubFetchMeals: Result<Meals, Error>?
    public var didFetchMeals: (() -> Void)?
    public var fetchMealsCallCount = 0

    func fetchMeals(for category: foodie.Category) async throws -> Meals {
        defer { didFetchMeals?() }
        fetchMealsCallCount += 1
        return try stubFetchMeals!.get()
    }

    public var stubLoadMeal: Meal?
    public var didLoadMeal: (() -> Void)?
    public var loadMealCallCount = 0

    func loadMeal(for mealId: String) async -> Meal? {
        defer { didLoadMeal?() }
        loadMealCallCount += 1
        return stubLoadMeal!
    }

    public var stubFetchMeal: Result<Meal, Error>?
    public var didFetchMeal: (() -> Void)?
    public var fetchMealCallCount = 0

    func fetchMeal(for mealId: String) async throws -> Meal {
        defer { didFetchMeal?() }
        fetchMealCallCount += 1
        return try stubFetchMeal!.get()
    }

    public var stubFetchRandomMeal: Result<Meal, Error>?
    public var didFetchRandomMeal: (() -> Void)?
    public var fetchRandomMealCallCount = 0

    func fetchRandomMeal() async throws -> Meal {
        defer { didFetchRandomMeal?() }
        fetchRandomMealCallCount += 1
        return try stubFetchRandomMeal!.get()
    }
}
