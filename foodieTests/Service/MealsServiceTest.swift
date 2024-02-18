//
//  MealsServiceTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 12/01/2023.
//

import XCTest
import Nimble
@testable import foodie

final class MealsServiceTest: XCTestCase, Mockable {

    var backendClient: APIClientMock!
    var persistanceClient: CoreDataClientMock!
    var sut: MealsClosureService!

    override func setUp() {
        backendClient = APIClientMock()
        persistanceClient = CoreDataClientMock()
        sut = MealsClosureService(
            backendClient: backendClient!,
            persistanceClient: persistanceClient!
        )
    }

    override func tearDown() {
        sut = nil
        backendClient = nil
        persistanceClient = nil
    }

    func testGetCategories() async throws {
        // Given
        let categories = Categories.mock
        backendClient.stubProcessResponse = .success(categories as Any)
        persistanceClient.stubGetCategoriesResponse = categories

        // When
        let result = try await sut.getCategories(handler: { _ in })

        // Then
        let assertion = categories

        expect(self.backendClient.processCallCount).to(equal(1))
        expect(result).to(equal(assertion))
    }
    
    func testGetMeals() async throws {
        // Given
        let meals = Meals.mock
        let category = Category.mock
        backendClient.stubProcessResponse = .success(meals as Any)
        persistanceClient.stubGetMealsResponse = meals

        // When
        let result = try await sut.getMeals(for: category, handler: { _ in })

        // Then
        let assertion = meals

        expect(self.backendClient.processCallCount).to(equal(1))
        expect(result).to(equal(assertion))
    }

    func testGetMeal() async throws {
        // Given
        let meal = Meal.mock
        backendClient.stubProcessResponse = .success(meal as Any)
        persistanceClient.stubGetMealResponse = meal

        // When
        let result = try await sut.getMeal(for: "1", handler: { _ in })

        // Then
        let assertion = meal

        expect(self.backendClient.processCallCount).to(equal(1))
        expect(result).to(equal(assertion))
    }

    func testGetRandomMeal() async throws {
        // Given
        let meal = Meal.mock
        backendClient.stubProcessResponse = .success(meal as Any)
        persistanceClient.stubGetMealResponse = meal

        // When
        let result = try await sut.getRandomMeal(handler: { _ in })

        // Then
        let assertion = meal

        expect(self.backendClient.processCallCount).to(equal(1))
        expect(result).to(equal(assertion))
    }
}
