//
//  SwiftDataClient.swift
//  mockedFoodie
//
//  Created by Konrad Groschang on 09/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import SwiftData

actor SwiftDataClient: PersistenceClient {

    private var context: ModelContext

    init(configuration: ModelConfiguration = ModelConfiguration()) throws {
        let container = try ModelContainer(for:
            CategorySwiftData.self,
            IngredientSwiftData.self,
            MealCategorySwiftData.self,
            MealDetailSwiftData.self,
            configurations: configuration
        )
        context = ModelContext(container)
    }

    // MARK: - Categories

    func getCategories() async -> Categories? {
        let descriptor = FetchDescriptor<CategorySwiftData>(sortBy: [SortDescriptor(\.name)])
        let categories: [CategorySwiftData]? = try? context.fetch(descriptor)
        return categories?.toCategories()
    }

    func saveCategories(_ categories: Categories) async {
        for item in categories.items {

            let category = CategorySwiftData(item)

            context.insert(category)
        }

        do {
            try context.save()
        } catch {
            Log.error("Unable to store data: \(error)")
        }
    }

    // MARK: - Meals

    func getMeals(for category: Category) async -> Meals? {
        let descriptor = FetchDescriptor<MealCategorySwiftData>(sortBy: [SortDescriptor(\.name)])
        //TODO: category
        let mealCategories = try? context.fetch(descriptor)
        return mealCategories?.toMeals()
    }

    func saveMeals(_ meals: Meals, for category: Category) async {

        guard let category = CategorySwiftData.get(object: category, in: context) else {
            Log.debug("Couldn't find related category object: \(category)")
            return
        }

        for item in meals.items {
            let meal = MealCategorySwiftData(item, category: category)
            context.insert(meal)
        }

        do {
            try context.save()
        } catch {
            Log.error("Unable to store data: \(error)")
        }
    }

    // MARK: - Meal

    func getMeal(for mealId: String) async -> Meal? {
        let meal = MealDetailSwiftData.get(id: mealId, in: context)
        return meal.map(Meal.init)
    }

    func saveMeal(_ meal: Meal) async {
        let meal = MealDetailSwiftData(meal)
        context.insert(meal)
        try? context.save()
    }
    
    func getRandomMeal() async -> Meal? {
        let meals = MealDetailSwiftData.get(in: context)
        let meal = meals?.randomElement()

        return meal.map(Meal.init)
    }

}


final class SwiftDataClientLogger: PersistenceClient {

    func getCategories() async -> Categories? { nil }

    func saveCategories(_ categories: Categories) async { }

    func getMeals(for category: Category) async -> Meals? { nil }

    func saveMeals(_ meals: Meals, for category: Category) async { }

    func getMeal(for mealId: String) async -> Meal? { nil }

    func getRandomMeal() async -> Meal? { nil }

    func saveMeal(_ meal: Meal) async { }

}
