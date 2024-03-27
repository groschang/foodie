//
//  MealsAsyncServicePreview.swift
//  foodie
//
//  Created by Konrad Groschang on 10/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

class MealsAsyncServicePreview: Sleepable, MealsAsyncServiceType {
    
    func loadCategories() async -> Categories? {
        await sleep()
        return .stub
    }
    
    func fetchCategories() async throws -> Categories {
        await sleep()
        return .stub
    }
    
    func getMeals(for category: Category) async -> Meals? {
        await sleep()
        return .stub
    }
    
    func fetchMeals(for category: Category) async throws -> Meals {
        await sleep()
        return .stub
    }
    
    func loadMeal(for mealId: String) async -> Meal? {
        await sleep()
        return .stub
    }
    
    func fetchMeal(for mealId: String) async throws -> Meal {
        await sleep()
        return .stub
    }
    
    func fetchRandomMeal() async throws -> Meal {
        await sleep()
        return .stub
    }

}
