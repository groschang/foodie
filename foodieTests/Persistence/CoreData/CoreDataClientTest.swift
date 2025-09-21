//
//  CoreDataClientTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 27/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Testing
import CoreData
@testable import foodie

@Suite struct CoreDataClientTest {

    var sut: CoreDataClient!

    init() async {
        let bundle = Bundle.main
        let modelURL = bundle.url(forResource: PersistentContainer.DataModelName,
                                  withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOf: modelURL)!
        let container = PersistentContainer(name: PersistentContainer.DataModelName,
                                            managedObjectModel: model,
                                            type: .inMemory)

        sut = CoreDataClient(container: container)
    }

    @Test("Test saving and retrieving categories")
    func testCategories() async {
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

        #expect(result == assertion)
    }

    @Test("Test saving and retrieving meals")
    func testMeals() async {
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

        #expect(result == assertion)
    }

    @Test("Test retrieving meals for non-existing category")
    func testMealsForNonExistingCategory() async {
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

        #expect(result == nil)
    }

    @Test("Test saving and retrieving meal with minimal parameters")
    func testMeal() async {
        // Given
        let meal = Meal(id: "1", name: "name")

        // When
        await sut.saveMeal(meal)

        // Then
        let result = await sut.getMeal(for: "1")!

        let assertion = Meal(id: "1", name: "name")

        #expect(result == assertion)
    }

    @Test("Test saving and retrieving meal with all parameters")
    func testMealAllParameters() async {
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

        #expect(result == assertion)
    }

    @Test("Test saving and retrieving meal ingredients")
    func testMealIngredients() async {
        // Given
        let ingredients = [Ingredient(name: "name", measure: "measure1"),
                           Ingredient(name: "name2", measure: "measure2")]

        let meal = Meal(id: "1",
                        name: "name",
                        ingredients: ingredients)

        await sut.saveMeal(meal)

        // When
        let result = await sut.getMeal(for: "1")

        // Then
        let assertionIngredients = [Ingredient(name: "name", measure: "measure1"),
                                    Ingredient(name: "name2", measure: "measure2")]

        let assertion = Meal(id: "1", name: "name",
                             ingredients: assertionIngredients)

        #expect(assertion == result)
        #expect(result?.ingredients == assertion.ingredients)
    }

    @Test("Test updating meal ingredients")
    func testMealUpdateIngredients() async {
        // Given
        let ingredients: [Ingredient]? = [Ingredient(name: "name5", measure: "measure5")]
        let meal = Meal(id: "1",
                        name: "name",
                        ingredients: ingredients)

        await sut.saveMeal(meal)

        // When
        var storedMeal: Meal? = await sut.getMeal(for: "1")

        let newIngredients = [Ingredient(name: "name", measure: "measure"),
                              Ingredient(name: "name3", measure: "measure3"),
                              Ingredient(name: "name4", measure: "measure4")]

        storedMeal?.ingredients = newIngredients

        await sut.updateMeal(storedMeal!)

        // Then
        let result = await sut.getMeal(for: "1")

        let assertionIngredients = [Ingredient(name: "name", measure: "measure"),
                                    Ingredient(name: "name3", measure: "measure3"),
                                    Ingredient(name: "name4", measure: "measure4")]

        let assertion = Meal(id: "1",
                             name: "name",
                             ingredients: assertionIngredients)

        #expect(assertion == result)
        #expect(result?.ingredients == assertion.ingredients)
    }
}
