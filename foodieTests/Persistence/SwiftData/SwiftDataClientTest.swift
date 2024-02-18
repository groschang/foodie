//
//  SwiftDataClientTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 18/02/2024.
//

//#if canImport(SwiftData)
import XCTest
import Nimble
import SwiftData
import Combine
@testable import foodie_ios17
//#endif

/// Swift Data requires iOS 17
//@available(iOS 17, *)
final class SwiftDataClientTest: XCTestCase {

    var sut: SwiftDataClient!
    var cancellable: AnyCancellable!

    override func setUpWithError() throws {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        sut = try SwiftDataClient(configuration: configuration)
    }

    override func tearDownWithError() throws {
        sut = nil
        cancellable = nil
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

//        XCTAssertEqual(result, assertion)
        expect(result).to(equal(assertion))
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

//        XCTAssertEqual(result, assertion)
        expect(result).to(equal(assertion))
    }

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

//        XCTAssertNil(result)
        expect(result).to(beNil())
    }

    func testMeal() async {

        // Given
        let meal = Meal(id: "1", name: "name")

        // When
        await sut.saveMeal(meal)

        // Then
        let result = await sut.getMeal(for: "1")!

        let assertion = Meal(id: "1", name: "name")

        XCTAssertEqual(result, assertion)
    }

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

        //        XCTAssertEqual(result, assertion)
                expect(result).to(equal(assertion))
    }

    func testMealIngredients() async {

        // Given
        let ingredients = [Ingredient(name: "name", measure: "measure1"),
                           Ingredient(name: "name2", measure: "measure2")]

        let meal = Meal(id: "1", name: "name",
                        ingredients: ingredients)

        await sut.saveMeal(meal)

        // When
        let result = await sut.getMeal(for: "1")

        // Then
        let assertionIngredients = [Ingredient(name: "name", measure: "measure1"),
                                    Ingredient(name: "name2", measure: "measure2")]

        let assertion = Meal(id: "1", name: "name",
                            ingredients: assertionIngredients)


        //        XCTAssertEqual(result, assertion)
        expect(result).to(equal(assertion))
        //        XCTAssertEqual(result?.ingredients, assertion.ingredients)
        expect(result?.ingredients).to(equal(assertion.ingredients))
    }

    func testMealUpdateIngredients() async {

        // Given
        let expectation = expectation(description: #function)

        let ingredients: [Ingredient]? = [Ingredient(name: "name5", measure: "measure5")]
        let meal = Meal(id: "1", name: "name",
                        ingredients: ingredients)

        await sut.saveMeal(meal)

        // When
        var storedMeal: Meal? = await sut.getMeal(for: "1")

        let newIngredients = [Ingredient(name: "name", measure: "measure"),
                            Ingredient(name: "name3", measure: "measure3"),
                            Ingredient(name: "name4", measure: "measure4")]


        storedMeal?.ingredients = newIngredients

//        cancellable = assignDidSaveExpectation(expectation)

//        await sut.updateMeal(storedMeal!)
        await sut.saveMeal(storedMeal!)

        // Then
//        await fulfillment(of: [expectation], timeout: 5.0)

        let result = await sut.getMeal(for: "1")

        let assertionIngredients = [Ingredient(name: "name", measure: "measure"),
                                    Ingredient(name: "name3", measure: "measure3"),
                                    Ingredient(name: "name4", measure: "measure4")]

        let assertion = Meal(id: "1", name: "name",
                            ingredients: assertionIngredients)

        //        XCTAssertEqual(result, assertion)
        expect(result).to(equal(assertion))
        //        XCTAssertEqual(result?.ingredients, assertion.ingredients)
        expect(result?.ingredients).to(equal(assertion.ingredients))
    }

}

//@available(iOS 17, *)
//extension SwiftDataClientTest {
//
//    @inlinable func assignDidSaveExpectation (_ expectation: XCTestExpectation) -> AnyCancellable {
//        NotificationCenter
//            .default
//            .publisher(for: .NSManagedObjectContextDidSave)
//            .dropFirst()
//            .sink { [weak expectation] _ in
//                expectation?.fulfill()
//            }
//    }
//}

