//
//  APIClientTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 20/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import XCTest
import Nimble
@testable import foodie

final class APIClientTest: XCTestCase {

    var sut: HTTPClient!
    var httpSession: HTTPSessionMock!
    var requestBuilder: RequestBuilderMock!

    override func setUp() {
        let enviroment = APIEndpoint.test

        httpSession = HTTPSessionMock()
        requestBuilder = RequestBuilderMock(enviroment: enviroment)

        sut = APIClient(
            session: httpSession,
            requestBuilder: requestBuilder,
            decoder: JSONDecoder()
        )
    }

    override func tearDown() {
        sut = nil
    }

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
        expect(buildCallCount) == 1
        let dataCallCount = await self.httpSession.dataCallCount
        expect(dataCallCount) == 1
        expect(result).to(equal(assertion))
    }

    func testAPICallServerFailure() async throws {

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

        await expect { try await self.sut.process(request) }
            .to(throwError { (error: Error) in
                expect(error).to(beAKindOf(APIError.self))
                expect(error.localizedDescription).to(contain("Status Code: 500"))
            })

        let buildCallCount = await self.requestBuilder.buildCallCount
        expect(buildCallCount) == 1
        let dataCallCount = await self.httpSession.dataCallCount
        expect(dataCallCount) == 1

    }

    func testAPICallNetworkFailure() async throws {

        // Given
        let endpoint = Endpoint(path: "/categories")
        let request = Request<TestObject>(endpoint: endpoint)

        let url = URL(string: "https://example.com/api/v1/categories")!
        let urlRequest = URLRequest(url: url)

        await requestBuilder.setStubBuildResponse(.success(urlRequest))

        await httpSession.setStubDataResponse(.failure(NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL)))

        // When -> Then

        await expect { try await self.sut.process(request) }.to(throwError(APIError.unknown))

        let buildCallCount = await self.requestBuilder.buildCallCount
        expect(buildCallCount) == 1
        let dataCallCount = await self.httpSession.dataCallCount
        expect(dataCallCount) == 1

    }

    func testAPICallJSONDecodingFailure() async throws {

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

        await expect { try await self.sut.process(request) }.to(throwError { (error: Error) in
            expect(error).to(beAKindOf(APIError.self))
            expect(error.localizedDescription).to(contain("The given data was not valid JSON."))
        })

        let buildCallCount = await self.requestBuilder.buildCallCount
        expect(buildCallCount) == 1
        let dataCallCount = await self.httpSession.dataCallCount
        expect(dataCallCount) == 1

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
