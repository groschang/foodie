//
//  RealmClientTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 22/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Testing
@testable import foodie
import Realm
import Realm.Dynamic
import RealmSwift

@Suite class RealmClientTest {

    var sut: RealmClient!
    var testDir: String!

    init() async {
        createRealmTestFolder()
        sut = RealmClient(realmConfiguration: realmConfigurationWithTestPath())
    }

    deinit {
        deleteRealmTestDatabase()
    }

    @Test func testCategories() async {
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

        #expect(assertion == result)
    }

    @Test func testCategoriesForFailureNotAll() async {
        // Given
        let categories = Categories(items: [
            Category(id: "1",
                     name: "name",
                     imageUrl: nil,
                     description: "description")
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

        #expect(assertion != result)
    }

    @Test func testMeals() async {
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

        #expect(assertion == result)
    }

    @Test func testMealsForFailureNonExistingCategory() async {
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

    @Test func testMeal() async {
        // Given
        let meal = Meal(id: "1", name: "name")

        // When
        await sut.saveMeal(meal)

        // Then
        let result = await sut.getMeal(for: "1")!

        let assertion = Meal(id: "1", name: "name")

        #expect(assertion == result)
    }

    @Test func testMealAllParameters() async {
        // Given
        let meal = Meal(id: "1",
                        name: "name",
                        category: "category",
                        area: "area",
                        recipe: "recipe",
                        imageURL: URL(string: "www.example.com"),
                        youtubeURL: URL(string: "www.example.com"),
                        source: "source",
                        ingredients:
                            [Ingredient(name: "name", measure: "measure"),
                             Ingredient(name: "name2", measure: "measure2")])

        await sut.saveMeal(meal)

        // When
        let result = await sut.getMeal(for: "1")

        // Then
        let assertion = Meal(id: "1",
                             name: "name",
                             category: "category",
                             area: "area",
                             recipe: "recipe",
                             imageURL: URL(string: "www.example.com"),
                             youtubeURL: URL(string: "www.example.com"),
                             source: "source",
                             ingredients: [Ingredient(name: "name", measure: "measure"),
                                           Ingredient(name: "name2", measure: "measure2")])

        #expect(assertion == result)
    }

    @Test func testMealIngredients() async {
        // Given
        let meal = Meal(
            id: "1",
            name: "name",
            ingredients:
                [Ingredient(name: "name", measure: "measure"),
                 Ingredient(name: "name2", measure: "measure2")]
        )

        await sut.saveMeal(meal)

        // When
        let result = await sut.getMeal(for: "1")

        // Then
        let assertion = Meal(
            id: "1",
            name: "name",
            ingredients:
                [Ingredient(name: "name", measure: "measure"),
                 Ingredient(name: "name2", measure: "measure2")]
        )

        #expect(assertion == result)
        #expect(assertion.ingredients == result?.ingredients)
    }

    @Test func testMealUpdateIngredients() async {
        // Given
        let ingredients = [Ingredient(name: "name", measure: "measure"),
                           Ingredient(name: "name2", measure: "measure2")]

        let meal = Meal(id: "1",
                        name: "name",
                        ingredients: ingredients)

        await sut.saveMeal(meal)

        // When
        var storedMeal = await sut.getMeal(for: "1")

        let ingredients2 = [Ingredient(name: "name", measure: "measure"),
                            Ingredient(name: "name3", measure: "measure3"),
                            Ingredient(name: "name4", measure: "measure4")]

        #expect(storedMeal != nil, "Couldn't load stored meal")

        storedMeal?.ingredients = ingredients2

        await sut.saveMeal(storedMeal!)

        let result = await sut.getMeal(for: "1")

        // Then
        let assertion = Meal(id: "1",
                             name: "name",
                             ingredients:
                                [Ingredient(name: "name", measure: "measure"),
                                 Ingredient(name: "name3", measure: "measure3"),
                                 Ingredient(name: "name4", measure: "measure4")])

        #expect(assertion == result)
        #expect(assertion.ingredients == result?.ingredients)
    }
}

fileprivate extension RealmClientTest {

    func createRealmTestFolder() {
        testDir = RLMRealmPathForFile(realmFilePrefix())

        do {
            try FileManager.default.removeItem(atPath: testDir)
        } catch {
            // The directory shouldn't actually already exist, so not an error
        }

        try! FileManager.default.createDirectory(
            at: URL(fileURLWithPath: testDir, isDirectory: true),
            withIntermediateDirectories: true,
            attributes: nil
        )

        let config = Realm.Configuration(fileURL: testRealmURL())
        Realm.Configuration.defaultConfiguration = config
    }

    func deleteRealmTestDatabase() {
        do {
            try FileManager.default.removeItem(atPath: testDir)
        } catch {
            #expect(Bool(false), "Unable to delete realm files")
        }

        // Verify that there are no remaining realm test files after the test
        let testDirPath = (testDir as String)
        guard let itemURLs = FileManager.default.enumerator(atPath: testDirPath) else { return }

        for url in itemURLs {
            let url = url as! NSString
            #expect(url.pathExtension != "realm", "Lingering realm file at \(testDirPath)/\(url)")
        }
    }

    func realmWithTestPath(configuration: Realm.Configuration = Realm.Configuration()) -> Realm {
        let configuration = realmConfigurationWithTestPath(configuration: configuration)
        return try! Realm(configuration: configuration)
    }

    func realmConfigurationWithTestPath(
        configuration: Realm.Configuration = Realm.Configuration()
    ) -> Realm.Configuration {
        var configuration = configuration
        configuration.fileURL = testRealmURL()
        return configuration
    }

    private func realmFilePrefix() -> String {
        // Generate a unique prefix for each test run
        return "RealmClientTest_\(UUID().uuidString)"
    }

    func testRealmURL() -> URL {
        realmURLForFile("test.realm")
    }

    func defaultRealmURL() -> URL {
        realmURLForFile("default.realm")
    }

    func realmURLForFile(_ fileName: String) -> URL {
        let directory = URL(fileURLWithPath: testDir, isDirectory: true)
        return directory.appendingPathComponent(fileName, isDirectory: false)
    }
}
