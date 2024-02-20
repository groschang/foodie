//
//  RequestBuilderMock.swift
//  foodieTests
//
//  Created by Konrad Groschang on 20/02/2024.
//

import XCTest
@testable import foodie

class RequestBuilderMock: RequestBuilder {

    let enviroment: foodie.APIEndpoint

    required init(enviroment: foodie.APIEndpoint) {
        self.enviroment = enviroment
    }

    public var stubBuildResponse: Result<URLRequest, Error>?
    public var didBuild: (() -> Void)?
    public var buildCallCount = 0

    func build<T>(for request: foodie.Request<T>) throws -> URLRequest where T : Decodable, T : Encodable {
        defer { didBuild?() }
        buildCallCount += 1
        return try stubBuildResponse!.get()
    }

}
