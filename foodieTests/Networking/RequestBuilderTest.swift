//
//  RequestBuilderTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 20/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import XCTest
import Nimble
@testable import foodie

final class RequestBuilderTest: XCTestCase {

    var sut: RequestBuilder!

    override func setUpWithError() throws {
        sut = URLRequestBuilder(enviroment: .test)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testRequest() throws {

        // Arrange
        let endpoint = Endpoint(path: "/categories")
        let request = Request<String>(endpoint: endpoint)

        // Act
        let result = try sut.build(for: request)

        // Assert
        let assertion = "https://example.com/api/v1/categories"

        expect(result.url?.absoluteString).to(equal(assertion))
    }

    func testRequestWithQueryItem() throws {

        // Arrange
        let endpoint = Endpoint(
            path: "/categories",
            queryItems: [
                URLQueryItem(name: "c", value: "123")
            ]
        )
        let request = Request<String>(endpoint: endpoint)

        // Act
        let result = try sut.build(for: request)

        // Assert
        let assertion = "https://example.com/api/v1/categories?c=123"

        expect(result.url?.absoluteString).to(equal(assertion))
    }

    func testRequestWithQueryItems() throws {

        // Arrange
        let endpoint = Endpoint(
            path: "/categories",
            queryItems: [
                URLQueryItem(name: "q1", value: "123"),
                URLQueryItem(name: "q2", value: "345")
            ]
        )
        let request = Request<String>(endpoint: endpoint)

        // Act
        let result = try sut.build(for: request)

        // Assert
        let assertion = "https://example.com/api/v1/categories?q1=123&q2=345"

        expect(result.url?.absoluteString).to(equal(assertion))
    }

    func testRequestWithHeaders() throws {

        // Arrange
        let endpoint = Endpoint(
            path: "/categories",
            queryItems: [
                URLQueryItem(name: "c", value: "123")
            ]
        )
        let headers: [String : String]? = ["h1":"v1"]
        let request = Request<String>(endpoint: endpoint, headers: headers)

        // Act
        let result = try sut.build(for: request)

        // Assert
        let assertion = ["h1":"v1"]

        expect(result.allHTTPHeaderFields).to(equal(assertion))
    }

}

