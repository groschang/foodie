//
//  APIClientTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 20/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Testing
import Foundation
@testable import foodie

@Suite struct APIClientTest {

    var sut: HTTPClient!
    var httpSession: HTTPSessionMock!
    var requestBuilder: RequestBuilderMock!

    init() async {
        let enviroment = APIEndpoint.test

        httpSession = HTTPSessionMock()
        requestBuilder = RequestBuilderMock(enviroment: enviroment)

        sut = APIClient(
            session: httpSession,
            requestBuilder: requestBuilder,
            decoder: JSONDecoder()
        )
    }

    @Test("Test successful API call returns expected data")
    func testAPICallSuccess() async throws {

        // Given
        let endpoint = Endpoint(path: "/categories")
        let request = Request<TestObject>(endpoint: endpoint)

        let url = URL(string: "https://example.com/api/v1/categories")!
        let urlRequest = URLRequest(url: url)

        await requestBuilder.setStubBuildResponse(.success(urlRequest))

        let data = APIEndpoint.testObjectJSON.data(using: .utf8)!
        let response = HTTPURLResponse(url: url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)!

        await httpSession.setStubDataResponse(.success((data, response)))

        // When
        let result = try await sut.process(request)

        // Then
        let assertion = TestObject.stub

        let buildCallCount = await self.requestBuilder.buildCallCount
        #expect(buildCallCount == 1)
        let dataCallCount = await self.httpSession.dataCallCount
        #expect(dataCallCount == 1)
        #expect(result == assertion)
    }

    @Test("Test API call handles server error response")
    func testAPICallServerFailure() async {

        // Given
        let endpoint = Endpoint(path: "/categories")
        let request = Request<TestObject>(endpoint: endpoint)

        let url = URL(string: "https://example.com/api/v1/categories")!
        let urlRequest = URLRequest(url: url)

        await requestBuilder.setStubBuildResponse(.success(urlRequest))

        let data = APIEndpoint.testObjectJSON.data(using: .utf8)!
        let response = HTTPURLResponse(url: url,
                                       statusCode: 500,
                                       httpVersion: nil,
                                       headerFields: nil)!

        await httpSession.setStubDataResponse(.success((data, response)))

        // When -> Then
        await #expect(throws: APIError.self) {
            try await self.sut.process(request)
        }

        let buildCallCount = await self.requestBuilder.buildCallCount
        #expect(buildCallCount == 1)
        let dataCallCount = await self.httpSession.dataCallCount
        #expect(dataCallCount == 1)
    }

    @Test("Test API call handles network failure")
    func testAPICallNetworkFailure() async {

        // Given
        let endpoint = Endpoint(path: "/categories")
        let request = Request<TestObject>(endpoint: endpoint)

        let url = URL(string: "https://example.com/api/v1/categories")!
        let urlRequest = URLRequest(url: url)

        await requestBuilder.setStubBuildResponse(.success(urlRequest))

        await httpSession.setStubDataResponse(.failure(NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL)))

        // When -> Then
        await #expect(throws: APIError.unknown) {
            try await self.sut.process(request)
        }

        let buildCallCount = await self.requestBuilder.buildCallCount
        #expect(buildCallCount == 1)
        let dataCallCount = await self.httpSession.dataCallCount
        #expect(dataCallCount == 1)
    }

    @Test("Test API call handles JSON decoding failure")
    func testAPICallJSONDecodingFailure() async {

        // Given
        let endpoint = Endpoint(path: "/categories")
        let request = Request<TestObject>(endpoint: endpoint)

        let url = URL(string: "https://example.com/api/v1/categories")!
        let urlRequest = URLRequest(url: url)

        await requestBuilder.setStubBuildResponse(.success(urlRequest))

        /// Incorrect json file
        let data = APIEndpoint.testObjectJSON.appending("json").data(using: .utf8)!
        let response = HTTPURLResponse(url: url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)!

        await httpSession.setStubDataResponse(.success((data, response)))

        // When -> Then
        await #expect(throws: APIError.self) {
            try await self.sut.process(request)
        }

        let buildCallCount = await self.requestBuilder.buildCallCount
        #expect(buildCallCount == 1)
        let dataCallCount = await self.httpSession.dataCallCount
        #expect(dataCallCount == 1)
    }

}



struct TestObject: Decodable, Encodable, Equatable {
    let name: String
    let surname: String
}

extension TestObject {
    static let stub = TestObject(name: "Johnny", surname: "Appleseed")
}

extension APIEndpoint {
    static let testObjectJSON = """
    {
        "name": "Johnny",
        "surname": "Appleseed"
    }
    """
}
