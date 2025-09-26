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

    private var realm: Realm?
    private let configuration: Realm.Configuration

    init(realmConfiguration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = realmConfiguration
    }

    private func getRealm() async throws -> Realm {
        if let realm = self.realm {
            return realm
        }
        let realm = try await Realm(configuration: self.configuration, actor: self)
        self.realm = realm
        return realm
    }


    // MARK: - Categories

    func getCategories() async -> Categories? {
        do {
            let realm = try await getRealm()
            return realm
                .objects(CategoryRealm.self)
                .toCategories()
        } catch {
            Log.error("Unable to get categories: \(error)")
            return nil
        }
    }

    func getCategory(id: ObjectID) async -> Category? {
        do {
            let realm = try await getRealm()
            return realm
                .objects(CategoryRealm.self)
                .where { $0.identifier == id }
                .first
                .map(Category.init)
        } catch {
            Log.error("Unable to get category: \(error)")
            return nil
        }
    }

    func saveCategories(_ categories: Categories) async {
        let objects: [CategoryRealm] = categories.items.map(CategoryRealm.init)
        do {
            let realm = try await getRealm()
            try await realm.asyncWrite {
                realm.add(objects, update: .modified)
            }
        } catch {
            Log.error("Unable to store data: \(error)")
        }
    }


    // MARK: - Meals

    func getMeals(for category: Category) async -> Meals? {
        do {
            let realm = try await getRealm()
            return realm
                .objects(MealCategoryRealm.self)
                .where { $0.category.identifier == category.identifier }
                .toMeals()
        } catch {
            Log.error("Unable to get meals: \(error)")
            return nil
        }
    }

    func saveMeals(_ meals: Meals, for category: Category) async {

        guard let category = await getCategory(id: category.identifier) else { return }
        let realmCategory = CategoryRealm(category)

        let objects: [MealCategoryRealm] = meals.items.map {
            MealCategoryRealm($0, category: realmCategory)
        }

        do {
            let realm = try await getRealm()
            try await realm.asyncWrite {
                realm.add(objects, update: .modified)
            }
        } catch {
            Log.error("Unable to store data: \(error)")
        }
    }


    // MARK: - Meal

    func getMeal(for mealId: ObjectID) async -> Meal? {
        do {
            let realm = try await getRealm()
            return realm
                .objects(MealDetailRealm.self)
                .where { $0.identifier == mealId }
                .first
                .map(Meal.init)
        } catch {
            Log.error("Unable to get meal: \(error)")
            return nil
        }
    }

    func saveMeal(_ meal: Meal) async {
        let meal = MealDetailRealm(meal)
        do {
            let realm = try await getRealm()
            try await realm.asyncWrite {
                realm.add(meal, update: .modified)
            }
        } catch {
            Log.error("Unable to store data: \(error)")
        }
    }

    func getRandomMeal() async -> Meal? {
        do {
            let realm = try await getRealm()
            return realm
                .objects(MealDetailRealm.self)
                .randomElement()
                .map(Meal.init)
        } catch {
            Log.error("Unable to get random meal: \(error)")
            return nil
        }
    }

}
