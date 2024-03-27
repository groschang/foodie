//
//  MealsPersistable.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

protocol CategoriesPersistenceClient {
    func getCategories() async -> Categories?
    func saveCategories(_ categories: Categories) async
}

protocol MealsPersistenceClient {
    func getMeals(for category: Category) async -> Meals?
    func saveMeals(_ meals: Meals, for category: Category) async
}

protocol MealPersistenceClient {
    func getMeal(for mealId: String) async -> Meal?
    func getRandomMeal() async -> Meal?
    func saveMeal(_ meal: Meal) async
}

typealias PersistenceClient = CategoriesPersistenceClient & MealsPersistenceClient & MealPersistenceClient
