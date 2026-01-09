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

    private let configuration: Realm.Configuration

    init(realm: Realm? = nil) {
        // If caller passed a Realm instance, derive configuration from it.
        if let realm = realm {
            self.configuration = realm.configuration
        } else {
            self.configuration = Realm.Configuration.defaultConfiguration
        }
    }

    init(realmConfiguration configuration: Realm.Configuration) {
        self.configuration = configuration
    }

    @MainActor
    private func makeRealmOnMain() -> Realm {
        try! Realm(configuration: configuration)
    }

    // Create Realm on the background actor for BackgroundActor methods
    @BackgroundActor
    private func makeRealmOnBackground() -> Realm {
        try! Realm(configuration: configuration)
    }

    // MARK: Categories

    @MainActor
    func getCategories() async -> Categories? {
        let realm = makeRealmOnMain()
        return realm
            .objects(CategoryRealm.self)
            .toCategories()
    }

    @MainActor
    func getCategory(id: ObjectID) async -> Category? {
        let realm = makeRealmOnMain()
        return realm
            .objects(CategoryRealm.self)
            .where { $0.identifier == id }
            .first
            .map(Category.init)
    }

    @BackgroundActor
    func saveCategories(_ categories: Categories) async {
        let objects: [CategoryRealm] = categories.items.map(CategoryRealm.init)
        let realm = makeRealmOnBackground()
        await realm.saveAsync(objects)
    }


    // MARK: Meals

    @MainActor
    func getMeals(for category: Category) async -> Meals? {
        let realm = makeRealmOnMain()
        return realm
            .objects(MealCategoryRealm.self)
            .where { $0.category.identifier == category.identifier }
            .toMeals()

    }

    @BackgroundActor
    func saveMeals(_ meals: Meals, for category: Category) async {
        guard let category = await getCategory(id: category.identifier) else { return }
        let realmCategory = CategoryRealm(category)

        let objects: [MealCategoryRealm] = meals.items.map {
            MealCategoryRealm($0, category: realmCategory)
        }

        let realm = makeRealmOnBackground()
        await realm.saveAsync(objects)
    }


    // MARK: Meal

    @MainActor
    func getMeal(for mealId: ObjectID) async -> Meal? {
        let realm = makeRealmOnMain()
        return realm
            .objects(MealDetailRealm.self)
            .where { $0.identifier == mealId }
            .first
            .map(Meal.init)
    }

    @BackgroundActor
    func saveMeal(_ meal: Meal) async {
        let meal = MealDetailRealm(meal)
        let realm = makeRealmOnBackground()
        await realm.saveAsync(meal)
    }

    @MainActor
    func getRandomMeal() async -> Meal? {
        let realm = makeRealmOnMain()
        return realm
            .objects(MealDetailRealm.self)
            .randomElement()
            .map(Meal.init)
    }

}
