//
//  APIClientMock.swift
//  foodieTests
//
//  Created by Konrad Groschang on 27/07/2023.
//

import Foundation
@testable import foodie

public final class APIClientMock: HTTPClient {

    public var stubProcessResponse: Result<Any, Error>?
    public var didProcess: (() -> Void)?
    public var processCallCount = 0

    public func process<T: Decodable>(_ request: Request<T>) async throws -> T {
        defer { didProcess?() }
        processCallCount += 1
        return try stubProcessResponse?.get() as! T
    }
}
