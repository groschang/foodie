//
//  RequestBuilderMock.swift
//  foodieTests
//
//  Created by Konrad Groschang on 20/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import XCTest
@testable import foodie

final actor RequestBuilderMock: RequestBuilder {

    let enviroment: foodie.APIEndpoint

    init(enviroment: foodie.APIEndpoint) {
        self.enviroment = enviroment
    }

    public var stubBuildResponse: Result<URLRequest, Error>?
    public var didBuild: (() -> Void)?
    public var buildCallCount = 0

    func build<T>(for request: foodie.Request<T>) async throws -> URLRequest where T : Decodable, T : Encodable {
        defer { didBuild?() }
        buildCallCount += 1
        return try stubBuildResponse!.get()
    }

    public func setStubBuildResponse(_ response: Result<URLRequest, Error>?) {
        stubBuildResponse = response
    }

}
