//
//  RealmClient.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
@preconcurrency import RealmSwift

actor RealmClient: PersistenceClient {

    private let realm: Realm

    init(realm: Realm? = nil) {
        self.realm = realm ?? (try! Realm())
    }

    init(realmConfiguration configuration: Realm.Configuration) {
        self.realm = try! Realm(configuration: configuration)
    }


    // MARK: Categories

    @MainActor
    func getCategories() async -> Categories? {
        await realm
            .objects(CategoryRealm.self)
            .toCategories()
    }

    @MainActor
    func getCategory(id: ObjectID) async -> Category? {
        await       realm
            .objects(CategoryRealm.self)
            .where { $0.identifier == id }
            .first
            .map(Category.init)
    }

    func saveCategories(_ categories: Categories) async {
        let objects: [CategoryRealm] = categories.items.map(CategoryRealm.init)
        await realm.saveAsync(objects)
    }


    // MARK: Meals

    @MainActor
    func getMeals(for category: Category) async -> Meals? {
        await realm
            .objects(MealCategoryRealm.self)
            .where { $0.category.identifier == category.identifier }
            .toMeals()

    }

    func saveMeals(_ meals: Meals, for category: Category) async {

        guard let category = await getCategory(id: category.identifier) else { return }
        let realmCategory = CategoryRealm(category)

        let objects: [MealCategoryRealm] = meals.items.map {
            MealCategoryRealm($0, category: realmCategory)
        }

        await realm.saveAsync(objects)
    }


    // MARK: Meal

    @MainActor
    func getMeal(for mealId: ObjectID) async -> Meal? {
        await realm
            .objects(MealDetailRealm.self)
            .where { $0.identifier == mealId }
            .first
            .map(Meal.init)
    }

    func saveMeal(_ meal: Meal) async {
        let meal = MealDetailRealm(meal)
        await realm.saveAsync(meal)
    }

    @MainActor
    func getRandomMeal() async -> Meal? {
        await realm
            .objects(MealDetailRealm.self)
            .randomElement()
            .map(Meal.init)
    }

}
