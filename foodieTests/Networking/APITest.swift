//
//  APITest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 14/06/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Testing
import Foundation
import SnapshotTesting
import XCTest
@testable import foodie

@Suite struct APITest {
    /// https://www.themealdb.com/api.php
    private let requestBuilder = URLRequestBuilder(enviroment: .production)
    private var decoder: JSONDecoder!
    private var session: URLSession!

    init() {
        decoder = JSONDecoder()
        session = URLSession(configuration: .default)
    }

    @Test("Categories endpoint returns valid data")
    func testCategories() async throws {
        try await guardForSimulator(message: "Snapshot tests are only run on simulators")

        // Arrange
        let endpoint = Endpoint.categories
        let request = Request<Categories>(endpoint: endpoint)
        let urlRequest = try await requestBuilder.build(for: request)

        // Act
        let (data, response) = try await session.data(for: urlRequest)
        try validate(response: response)
        let json = data.prettyString

        // Assert
        assertSnapshot(of: urlRequest, as: .raw)
        assertSnapshot(of: json, as: .json, named: "testCategories")
    }

    @Test("Meals endpoint returns valid data")
    func testMeals() async throws {
        try await guardForSimulator(message: "Snapshot tests are only run on simulators")

        // Arrange
        let endpoint = Endpoint.meals(category: "Beef")
        let request = Request<Meals>(endpoint: endpoint)
        let urlRequest = try await requestBuilder.build(for: request)

        // Act
        let (data, response) = try await session.data(for: urlRequest)
        try validate(response: response)
        let json = data.prettyString

        // Assert
        assertSnapshot(of: urlRequest, as: .raw)
        assertSnapshot(of: json, as: .json, named: "testMeals")
    }

    @Test("Meal endpoint returns valid data")
    func testMeal() async throws {
        try await guardForSimulator(message: "Snapshot tests are only run on simulators")

        // Arrange
        let endpoint = Endpoint.meal(id: "52881")
        let request = Request<Meal>(endpoint: endpoint)
        let urlRequest = try await requestBuilder.build(for: request)

        // Act
        let (data, response) = try await session.data(for: urlRequest)
        try validate(response: response)
        let json = data.prettyString

        // Assert
        assertSnapshot(of: urlRequest, as: .raw)
        assertSnapshot(of: json, as: .json, named: "testMeal")
    }
}


private extension APITest {
    
    private func validate(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.noResponse
        }

        switch httpResponse.statusCode {
        case HttpStatusCode.successful:
            return
        case HttpStatusCode.clientError:
            throw APIError.client(httpResponse.statusCode)
        default:
            throw APIError.unexpected(httpResponse.statusCode)
        }
    }
    
    private func guardForSimulator(message: String) async throws {
        #if !targetEnvironment(simulator)
        throw XCTSkip(message)
        #endif
    }
}
