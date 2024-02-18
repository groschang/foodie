//
//  RealmClientTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 22/01/2024.
//

import XCTest
@testable import foodie
import Realm
import Realm.Dynamic
import RealmSwift

final class RealmClientTest: XCTestCase {

    var sut: RealmClient!

    var testDir: String!

    override func setUpWithError() throws {
        createRealmTestFolder()
        sut = RealmClient(realmConfiguration: realmConfigurationWithTestPath())
    }

    override func tearDownWithError() throws {
        deleteRealmTestDatabase()
    }

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

        XCTAssertEqual(assertion, result)

    }

    func testCategoriesForFailureNotAll() async {

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

        XCTAssertNotEqual(assertion, result)

    }

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

        XCTAssertEqual(assertion, result)
    }

    func testMealsForFailureNonExistingCategory() async {

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
    }

    func testMeal() async {

        // Given
        let meal = Meal(id: "1", name: "name")

        // When
        await sut.saveMeal(meal)

        // Then
        let result = await sut.getMeal(for: "1")!

        let assertion = Meal(id: "1", name: "name")

        XCTAssertEqual(assertion, result)

    }

    func testMealAllParameters() async {

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

        XCTAssertEqual(assertion, result)

    }

    func testMealIngredients() async {

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

        XCTAssertEqual(assertion, result)
        XCTAssertEqual(assertion.ingredients, result?.ingredients)
    }

    func testMealUpdateIngredients() async {

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

        storedMeal?.ingredients = ingredients2

        XCTAssertNotNil(storedMeal, "Couldn't load stored meal")

        await sut.saveMeal(storedMeal!)

        let result = await sut.getMeal(for: "1")

        // Then
        let assertion = Meal(id: "1",
                             name: "name",
                             ingredients:
                                [Ingredient(name: "name", measure: "measure"),
                                 Ingredient(name: "name3", measure: "measure3"),
                                 Ingredient(name: "name4", measure: "measure4")])

        XCTAssertEqual(assertion, result)
        XCTAssertEqual(assertion.ingredients, result?.ingredients)
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
            XCTFail("Unable to delete realm files")
        }

        // Verify that there are no remaining realm test files after the test
        let testDirPath = (testDir as String)
        guard let itemURLs = FileManager.default.enumerator(atPath: testDirPath) else { return }

        for url in itemURLs {
            let url = url as! NSString
            XCTAssertNotEqual(url.pathExtension, "realm", "Lingering realm file at \(testDirPath)/\(url)")
            assert(url.pathExtension != "realm")
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
        var name: String = self.name
        name = name.trimmingCharacters(in: CharacterSet(charactersIn: "-[]"))
        return name.replacingOccurrences(of: " ", with: "_")
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
