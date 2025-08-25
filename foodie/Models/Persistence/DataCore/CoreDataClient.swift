//
//  CoreDataClient.swift
//  foodie
//
//  Created by Konrad Groschang on 25/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
@preconcurrency import CoreData

actor CoreDataClient {

    private(set) var container: PersistentContainer

    private lazy var persistentContainer: PersistentContainer? = {
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private var viewContext: NSManagedObjectContext? {
        persistentContainer?.viewContext
    }

    init(container: PersistentContainer = PersistentContainer()) {
        self.container = container
    }

    private func newTaskContext() -> NSManagedObjectContext? {
        guard let container = persistentContainer else { return nil }
        let context = container.newBackgroundContext()
        context.mergePolicy = NSMergePolicy(merge: .overwriteMergePolicyType)
        context.automaticallyMergesChangesFromParent = true
        return context
    }

    private func fetch<T>(request: NSFetchRequest<T>) async -> [T]? where T: NSManagedObject {
        guard let viewContext else { return nil }
        return await viewContext.fetch(request: request)
    }

    private func fetch<T>(
        request: NSFetchRequest<T>,
        in context: NSManagedObjectContext
    ) async -> [T]? where T: NSManagedObject {
        await context.fetch(request: request)
    }
}

extension CoreDataClient: PersistenceClient {

    // MARK: Categories

    func getCategories() async -> Categories? {
        let request = CategoryEntity.fetchRequest()
        let sortByName = NSSortDescriptor(keyPath: \CategoryEntity.name,
                                          ascending: true)

        request.sortDescriptors = [sortByName]

        let fetchResult = await fetch(request: request)

        return fetchResult?.toCategories()
    }

    func saveCategories(_ categories: Categories) async {
        guard let context = newTaskContext() else { return }

        await context.perform { [weak persistentContainer, weak context] in
            guard let context, let persistentContainer else { return }

            _ = categories.items.map { CategoryEntity.init($0, context: context) }

            persistentContainer.saveContext(context) //TODO: throw api
        }
    }

    // MARK: Meals

    func getMeals(for category: Category) async -> Meals? {
        guard let categoryEntity = await getCategory(category) else {
            return nil
        }

        let request = MealCategoryEntity.fetchRequest()
        let sortByName = NSSortDescriptor(
            keyPath: \MealCategoryEntity.name,
            ascending: true
        )

        //        request.fetchLimit = 1
        request.sortDescriptors = [sortByName]
        request.predicate = NSPredicate(
            format: "category = %@", categoryEntity //TODO: category.name?
        )

        let fetchResult = await fetch(request: request)

        return fetchResult?.toMeals()
    }

    func saveMeals(_ meals: Meals, for category: Category) async {
        guard let context = newTaskContext() else { return }

        guard let categoryEntity = await getCategory(category, context: context) else { return }

        await context.perform { [weak persistentContainer, weak context] in
            guard let context, let persistentContainer else { return }

            let mealCategories = meals.items.map {
                MealCategoryEntity.init($0, context: context)
            }
            categoryEntity.addToMealCategories(NSSet(array: mealCategories))

            persistentContainer.saveContext(context) //TODO: throw api
        }
    }

    // MARK: Meal

    func getMeal(for mealId: String) async -> Meal? {
        let request = MealDetailEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", mealId)

        let fetchResult = await fetch(request: request)

        return fetchResult?.toMeal()
    }

    private func getMealDetailEntity(for mealId: String, context: NSManagedObjectContext? = nil) async -> MealDetailEntity? {
        let request = MealDetailEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", mealId)

        let fetchResult: [MealDetailEntity]?

        if let context {
            fetchResult = await fetch(request: request, in: context)
        } else {
            fetchResult = await fetch(request: request)
        }

        return fetchResult?.first
    }

    func updateMeal(_ meal: Meal) async {
        guard 
            let context = newTaskContext(),
            let mealDetailEntity = await getMealDetailEntity(for: meal.id, context: context)
        else { return }

        await context.perform { [weak persistentContainer, weak context, weak mealDetailEntity] in
            guard let context,
                  let persistentContainer,
                  let mealDetailEntity
            else { return }

            mealDetailEntity.map(meal: meal, context: context)
            persistentContainer.saveContext(context) //TODO: throw api
        }
    }

    func saveMeal(_ meal: Meal) async {
        guard let context = newTaskContext() else { return }

        await context.perform { [weak persistentContainer, weak context] in
            guard let context, let persistentContainer else { return }

            _ = MealDetailEntity.init(meal, context: context)

            persistentContainer.saveContext(context) //TODO: throw api
        }
    }

    func getRandomMeal() async -> Meal? {
        let request = MealDetailEntity.fetchRequest()

        let fetchResult = await fetch(request: request)

        return fetchResult?.randomElement().map(Meal.init)
    }
}


extension CoreDataClient {

    func getCategory(_ category: Category) async -> CategoryEntity? {
        guard let viewContext else { return nil }

        return await getCategory(category, context: viewContext)
    }

    func getCategory(_ category: Category, context: NSManagedObjectContext) async -> CategoryEntity? {

        let request = CategoryEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id LIKE %@", category.id)
        let objects = await fetch(request: request, in: context)
        return objects?.first
    }
}
