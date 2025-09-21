//
//  RequestBuilderTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 20/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Testing
import Foundation
@testable import foodie

@Suite class RequestBuilderTest {

    var sut: RequestBuilder!

    init() async {
        sut = URLRequestBuilder(enviroment: .test)
    }

    deinit {
        sut = nil
    }

    @Test func testRequest() async throws {
        // Arrange
        let endpoint = Endpoint(path: "/categories")
        let request = Request<String>(endpoint: endpoint)

        // Act
        let result = try await sut.build(for: request)

        // Assert
        let assertion = "https://example.com/api/v1/categories"

        #expect(result.url?.absoluteString == assertion)
    }

    @Test func testRequestWithQueryItem() async throws {
        // Arrange
        let endpoint = Endpoint(
            path: "/categories",
            queryItems: [
                URLQueryItem(name: "c", value: "123")
            ]
        )
        let request = Request<String>(endpoint: endpoint)

        // Act
        let result = try await sut.build(for: request)

        // Assert
        let assertion = "https://example.com/api/v1/categories?c=123"

        #expect(result.url?.absoluteString == assertion)
    }

    @Test func testRequestWithQueryItems() async throws {
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
        let result = try await sut.build(for: request)

        // Assert
        let assertion = "https://example.com/api/v1/categories?q1=123&q2=345"

        #expect(result.url?.absoluteString == assertion)
    }

    @Test func testRequestWithHeaders() async throws {
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
        let result = try await sut.build(for: request)

        // Assert
        let assertion = ["h1":"v1"]

        #expect(result.allHTTPHeaderFields == assertion)
    }
}
