//
//  CoreDataClientTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 27/07/2023.
//

import XCTest
import CoreData
@testable import foodie

final class CoreDataClientTest: XCTestCase {

    var sut: CoreDataClient!
    var counter = 0

    override func setUpWithError() throws {
        print("\(#function) setUp")
//        container = PersistentContainer(name: "foodie")
//        let bundle = Bundle(for: type(of: self))
        let bundle = Bundle.main
        let modelURL = bundle.url(forResource: PersistentContainer.DataModelName,
                                  withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOf: modelURL)!
        let container = PersistentContainer(name: PersistentContainer.DataModelName,
                                            managedObjectModel: model,
                                            type: .inMemory)
//        let container = PersistentContainer(bundle: bundle, type: .inMemory)
        sut = CoreDataClient(container: container)
    }

    override func tearDownWithError() throws {
        sut = nil
//        container = nil
        print("\(#function) tearDown")
    }

    func testCategories() async {
//        let container = PersistentContainer(type: .inMemory)
//        let sut = CoreDataClient(container: container)
        // Given
        let categories = Categories(items: [
            Category(id: "1",
                     name: "name",
                     imageUrl: nil,
                     description: "description"),
            Category(id: "2",
                     name: "name2",
                     imageUrl: URL(string: "www.example.com"),
                     description: "description2")
        ])

        // When
        await sut.saveCategories(categories)

        // Then
        let result = await sut.getCategories()!

        let assertion = Categories(items: [
            Category(id: "1",
                     name: "name",
                     imageUrl: nil,
                     description: "description"),
            Category(id: "2",
                     name: "name2",
                     imageUrl: URL(string: "www.example.com"),
                     description: "description2")
        ])

        XCTAssertEqual(assertion, result)
        counter += 1
        print("xxx \(#function) \(counter)")
    }

    func testMeals() async {
//        let container = PersistentContainer(type: .inMemory)
//        let sut = CoreDataClient(container: container)
        // Given
        let category = Category(id: "1",
                                name: "name",
                                imageUrl: URL(string: "www.example.com"),
                                description: "description")
        await sut.saveCategories(Categories(items: [category]))

        let meals = Meals(items: [
            MealCategory(id: "1",
                         name: "name",
                         imageUrl: nil),
            MealCategory(id: "2",
                         name: "name2",
                         imageUrl: URL(string: "www.example.com"))
        ])

        // When
        await sut.saveMeals(meals, for: category)

        // Then
        let result = await sut.getMeals(for: category)!

        let assertion = Meals(items: [
            MealCategory(id: "1",
                         name: "name",
                         imageUrl: nil),
            MealCategory(id: "2",
                         name: "name2",
                         imageUrl: URL(string: "www.example.com"))
        ])

        XCTAssertEqual(assertion, result)
        counter += 1
        print("xxx \(#function) \(counter)")
    }

    func testMealsForNonExistingCategory() async {
//        let container = PersistentContainer(type: .inMemory)
//        let sut = CoreDataClient(container: container)
        // Given
        let meals = Meals(items: [
            MealCategory(id: "1",
                         name: "name",
                         imageUrl: nil),
            MealCategory(id: "2",
                         name: "name2",
                         imageUrl: URL(string: "www.example.com"))
        ])
        let category = Category(id: "1",
                                name: "name",
                                imageUrl: URL(string: "www.example.com"),
                                description: "description")

        // When
        await sut.saveMeals(meals, for: category)

        // Then
        let result = await sut.getMeals(for: category)

        XCTAssertNil(result)
        counter += 1
        print("xxx \(#function) \(counter)")
    }

    func testMeal() async {
//        let container = PersistentContainer(type: .inMemory)
//        let sut = CoreDataClient(container: container)
        // Given
        let meal = Meal(id: "1", name: "name")

        // When
        await sut.saveMeal(meal)

        // Then
        let result = await sut.getMeal(for: "1")!

        let assertion = Meal(id: "1", name: "name")

        XCTAssertEqual(assertion, result)
        counter += 1
        print("xxx \(#function) \(counter)")
    }

    func testMealAllParameters() async {
//        let container = PersistentContainer(type: .inMemory)
//        let sut = CoreDataClient(container: container)
        // Given
        let ingredients = [Ingredient(name: "name", measure: "measure"),
                           Ingredient(name: "name2", measure: "measure2")]

        let meal = Meal(id: "1",
                        name: "name",
                        category: "category",
                        area: "area",
                        recipe: "recipe",
                        imageURL: URL(string: "www.example.com"),
                        youtubeURL: URL(string: "www.example.com"),
                        source: "source",
                        ingredients: ingredients)

        await sut.saveMeal(meal)

        // When
        let result = await sut.getMeal(for: "1")

        // Then
        let assertionIngredients = [Ingredient(name: "name", measure: "measure"),
                                   Ingredient(name: "name2", measure: "measure2")]

        let assertion = Meal(id: "1",
                            name: "name",
                            category: "category",
                            area: "area",
                            recipe: "recipe",
                            imageURL: URL(string: "www.example.com"),
                            youtubeURL: URL(string: "www.example.com"),
                            source: "source",
                            ingredients: assertionIngredients)

        XCTAssertEqual(assertion, result)
        counter += 1
        print("xxx \(#function) \(counter)")
    }

    func testMealIngredients() async {
//        let container = PersistentContainer(type: .inMemory)
//        let sut = CoreDataClient(container: container)
        // Given
        let ingredients = [Ingredient(name: "name", measure: "measure"),
                           Ingredient(name: "name2", measure: "measure2")]

        let meal = Meal(id: "1", name: "name",
                        ingredients: ingredients)

        await sut.saveMeal(meal)

        // When
        var storedMeal = await sut.getMeal(for: "1")

        let ingredients2 = [Ingredient(name: "name3", measure: "measure3"),
                            Ingredient(name: "name4", measure: "measure4")]

        storedMeal?.ingredients = ingredients2

        await sut.saveMeal(storedMeal!)

        let result = await sut.getMeal(for: "1")

        // Then
        let assertionIngredients = [Ingredient(name: "name", measure: "measure"),
                                   Ingredient(name: "name3", measure: "measure3"),
                                   Ingredient(name: "name4", measure: "measure4")]

        let assertion = Meal(id: "1", name: "name",
                            ingredients: assertionIngredients)

//        XCTAssertEqual(assertion, result)
//        XCTAssertEqual(assertion.ingredients, result?.ingredients)
        counter += 1
        print("xxx \(#function) \(counter)")
    }

    
}
