//
//  APIClientMock.swift
//  foodieTests
//
//  Created by Konrad Groschang on 27/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
@testable import foodie

public final actor APIClientMock: HTTPClient {

    public var stubProcessResponse: Result<Any, Error>?
    public var didProcess: (() -> Void)?
    public var processCallCount = 0

    public func process<T: Decodable & Sendable>(_ request: Request<T>) async throws -> T {
        defer { didProcess?() }
        processCallCount += 1
        guard let stubProcessResponse = stubProcessResponse else {
            throw MockError.unwrapStubError

        }
        let result = try stubProcessResponse.get()
        guard let typedResult = result as? T else {
            throw MockError.castingError
        }
        return typedResult
    }

    public func setStubProcessResponse(_ response: Result<Any, Error>?) {
        stubProcessResponse = response
    }
}
