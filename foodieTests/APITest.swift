//
//  APITest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 14/06/2023.
//

import XCTest
import SnapshotTesting
@testable import foodie

final class APITest: XCTestCase {

    /// https://www.themealdb.com/api.php
    private let requestBuilder = URLRequestBuilder(enviroment: .production)
    private var decoder: JSONDecoder!
    private var session: URLSession!

    override func setUp() {
        decoder = JSONDecoder()
        session = URLSession(configuration: .default)
    }

    func testCategories() async throws {
        //Arrange
        let endpoint = Endpoint.categories
        let request = Request<Categories>(endpoint: endpoint)
        let urlRequest = try requestBuilder.build(for: request)

        //Act
        let (data, response) = try await session.data(for: urlRequest)
        try validate(response: response)
        let json = prettyPrint(data: data)

        // Asset
        assertSnapshot(matching: urlRequest, as: .raw)
        assertSnapshot(matching: json, as: .json)
    }

    func testMeals() async throws {
        //Arrange
        let endpoint = Endpoint.meals(category: "Beef")
        let request = Request<Meals>(endpoint: endpoint)
        let urlRequest = try requestBuilder.build(for: request)

        //Act
        let (data, response) = try await session.data(for: urlRequest)
        try validate(response: response)
        let json = prettyPrint(data: data)

        // Asset
        assertSnapshot(matching: urlRequest, as: .raw)
        assertSnapshot(matching: json, as: .json)
    }

    func testMeal() async throws {
        //Arrange
        let endpoint = Endpoint.meal(id: "53057") //52881
        let request = Request<Meal>(endpoint: endpoint)
        let urlRequest = try requestBuilder.build(for: request)

        //Act
        let (data, response) = try await session.data(for: urlRequest)
        try validate(response: response)
        let json = prettyPrint(data: data)

        // Asset
        assertSnapshot(matching: urlRequest, as: .raw)
        assertSnapshot(matching: json, as: .json)
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

    private func prettyPrint(data: Data) -> String? {
        guard
            let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrinted = String(data: data, encoding: .utf8)
        else { return nil }

        return prettyPrinted
    }
}
