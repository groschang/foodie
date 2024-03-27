//
//  MealsAsyncStreamServiceMock.swift
//  foodie
//
//  Created by Konrad Groschang on 17/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
@testable import foodie

class MealsAsyncStreamServiceMock: Sleepable, MealsAsyncStreamServiceType {

    public var stubGetCategories: Result<Categories, Error>?
    public var didGetCategories: (() -> Void)?
    public var getCategoriesCallCount = 0

    func getCategories() -> AsyncThrowingStream<Categories, Error> {
        defer { didGetCategories?() }
        getCategoriesCallCount += 1
        return AsyncThrowingStream { continuation in
            switch stubGetCategories {
            case .success(let success):
                continuation.yield(success)
            case .failure(let failure):
                continuation.finish(throwing: failure)
            case nil:
                continuation.finish(throwing: nil)
            }
            continuation.finish()
        }
    }

    public var stubGetMeals: Result<Meals, Error>?
    public var didGetMeals: (() -> Void)?
    public var getMealsCallCount = 0

    func getMeals(for category: foodie.Category) -> AsyncThrowingStream<Meals, Error> {
        defer { didGetMeals?() }
        getMealsCallCount += 1
        return AsyncThrowingStream { continuation in
            switch stubGetMeals {
            case .success(let success):
                continuation.yield(success)
            case .failure(let failure):
                continuation.finish(throwing: failure)
            case nil:
                continuation.finish(throwing: nil)
            }
            continuation.finish()
        }
    }

    public var stubGetMeal: Result<Meal, Error>?
    public var didGetMeal: (() -> Void)?
    public var getMealCallCount = 0

    func getMeal(for mealId: String) -> AsyncThrowingStream<Meal, Error> {
        defer { didGetMeal?() }
        getMealCallCount += 1
        return AsyncThrowingStream { continuation in
            switch stubGetMeal {
            case .success(let success):
                continuation.yield(success)
            case .failure(let failure):
                continuation.finish(throwing: failure)
            case nil:
                continuation.finish(throwing: nil)
            }
            continuation.finish()
        }
    }

    public var stubRandomMeal: Result<Meal, Error>?
    public var didRandomMeal: (() -> Void)?
    public var getRandomCallCount = 0

    func getRandomMeal() -> AsyncThrowingStream<Meal, Error> {
        defer { didRandomMeal?() }
        getRandomCallCount += 1
        return AsyncThrowingStream { continuation in
            switch stubRandomMeal {
            case .success(let success):
                continuation.yield(success)
            case .failure(let failure):
                continuation.finish(throwing: failure)
            case nil:
                continuation.finish(throwing: nil)
            }
            continuation.finish()
        }
    }
}
