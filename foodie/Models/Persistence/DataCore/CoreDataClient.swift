//
//  CoreDataClient.swift
//  foodie
//
//  Created by Konrad Groschang on 25/01/2023.
//

import Foundation
import CoreData



class CoreDataClient {

    private(set) var container: PersistentContainer

    private lazy var persistentContainer: PersistentContainer? = {
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

//    private var persistentContainer: PersistentContainer? { container }

    private var viewContext: NSManagedObjectContext? {
        persistentContainer?.viewContext
    }

    init(container: PersistentContainer = PersistentContainer()) {
        self.container = container
    }

    private func newTaskContext() -> NSManagedObjectContext? {
        guard let container = persistentContainer else { return nil }
        let context = container.newBackgroundContext()
        context.mergePolicy = NSOverwriteMergePolicy // TODO: Check me
        context.automaticallyMergesChangesFromParent = true
        return context
    }

    private func fetch<T>(request: NSFetchRequest<T>) async -> [T]? where T: NSManagedObject {
        guard let viewContext else { return nil }
//        return await fetch(request: request, in: viewContext)
        return await viewContext.fetch(request: request)
    }

    private func fetch<T>(request: NSFetchRequest<T>, in context: NSManagedObjectContext) async -> [T]? where T: NSManagedObject {
                await context.fetch(request: request)
//        await context.perform {
//            do {
//                return try request.execute()
//            } catch {
//                Logger.log("Core data fetch problem: \(error)", onLevel: .error)
//                return nil
//            }
//        }
    }
}

extension CoreDataClient: PersistenceClient {

    func getCategories() async -> Categories? {
        let request = CategoryEntity.fetchRequest()
        let sortByName = NSSortDescriptor(keyPath: \CategoryEntity.name,
                                          ascending: true)

        request.sortDescriptors = [sortByName]

        let objects = await fetch(request: request)

        return objects?.toCategories()
    }

    func saveCategories(_ categories: Categories) async {
        guard let context = newTaskContext() else { return }

        await context.perform { [weak persistentContainer, weak context] in
            guard let context, let persistentContainer else { return }

            _ = categories.items.map { CategoryEntity.init($0, context: context) }

            persistentContainer.saveContext(context) //TODO: throw api
        }
    }

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

        let objects = await fetch(request: request)

        return objects?.toMeals()
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

    func getMeal(for mealId: String) async -> Meal? {
        let request = MealDetailEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", mealId)

        let objects = await fetch(request: request)

        return objects?.toMeals()
    }

    func saveMeal(_ meal: Meal) async {
        guard let context = newTaskContext() else { return }

        await context.perform { [weak persistentContainer, weak context] in
            guard let context, let persistentContainer else { return }

            _ = MealDetailEntity.init(meal, context: context)

            persistentContainer.saveContext(context) //TODO: throw api
        }
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
