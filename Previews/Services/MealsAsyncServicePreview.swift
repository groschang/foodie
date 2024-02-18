//
//  MealsAsyncServicePreview.swift
//  foodie
//
//  Created by Konrad Groschang on 10/07/2023.
//

import Foundation

class MealsAsyncServicePreview: Sleepable, MealsAsyncServiceType {
    
    func loadCategories() async -> Categories? {
        await sleep()
        return .mock
    }
    
    func fetchCategories() async throws -> Categories {
        await sleep()
        return .mock
    }
    
    func getMeals(for category: Category) async -> Meals? {
        await sleep()
        return .mock
    }
    
    func fetchMeals(for category: Category) async throws -> Meals {
        await sleep()
        return .mock
    }
    
    func loadMeal(for mealId: String) async -> Meal? {
        await sleep()
        return .mock
    }
    
    func fetchMeal(for mealId: String) async throws -> Meal {
        await sleep()
        return .mock
    }
    
    func fetchRandomMeal() async throws -> Meal {
        await sleep()
        return .mock
    }

}

