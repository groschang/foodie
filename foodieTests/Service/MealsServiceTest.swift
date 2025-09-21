//
//  MealsServiceTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 12/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Testing
@testable import foodie

@Suite struct MealsServiceTest {

    var backendClient: APIClientMock!
    var persistanceClient: CoreDataClientMock!
    var sut: MealsClosureService!

    init() async {
        backendClient = APIClientMock()
        persistanceClient = CoreDataClientMock()
        sut = MealsClosureService(
            backendClient: backendClient,
            persistanceClient: persistanceClient
        )
    }

    @Test("Test getting categories")
    func testGetCategories() async throws {
        // Given
        let categories = Categories.stub
        await backendClient.setStubProcessResponse(.success(categories as Any))
        await persistanceClient.setStubGetCategoriesResponse(categories)

        // When
        let result = try await sut.getCategories(handler: { _ in })

        // Then
        let assertion = categories

        let processCallCount = await self.backendClient.processCallCount
        #expect(processCallCount == 1)
        #expect(result == assertion)
    }
    
    @Test("Test getting meals for category")
    func testGetMeals() async throws {
        // Given
        let meals = Meals.stub
        let category = Category.stub
        await backendClient.setStubProcessResponse(.success(meals as Any))
        await persistanceClient.setStubGetMealsResponse(meals)

        // When
        let result = try await sut.getMeals(for: category, handler: { _ in })

        // Then
        let assertion = meals

        let processCallCount = await self.backendClient.processCallCount
        #expect(processCallCount == 1)
        #expect(result == assertion)
    }

    @Test("Test getting meal by ID")
    func testGetMeal() async throws {
        // Given
        let meal = Meal.stub
        await backendClient.setStubProcessResponse(.success(meal as Any))
        await persistanceClient.setStubGetMealResponse(meal)

        // When
        let result = try await sut.getMeal(for: "1", handler: { _ in })

        // Then
        let assertion = meal

        let processCallCount = await self.backendClient.processCallCount
        #expect(processCallCount == 1)
        #expect(result == assertion)
    }

    @Test("Test getting random meal")
    func testGetRandomMeal() async throws {
        // Given
        let meal = Meal.stub
        await backendClient.setStubProcessResponse(.success(meal as Any))
        await persistanceClient.setStubGetMealResponse(meal)

        // When
        let result = try await sut.getRandomMeal(handler: { _ in })

        // Then
        let assertion = meal

        let processCallCount = await self.backendClient.processCallCount
        #expect(processCallCount == 1)
        #expect(result == assertion)
    }
}
