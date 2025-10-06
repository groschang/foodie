//
//  NetworkSessionMock.swift
//  foodieTests
//
//  Created by Konrad Groschang on 04/09/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
@testable import foodie

final actor HTTPSessionMock: HTTPSession {

    public var stubDataResponse: Result<(Data, URLResponse), Error>?
    public var didData: (() -> Void)?
    public var dataCallCount = 0

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        defer { didData?() }
        dataCallCount += 1
        guard let stubDataResponse = stubDataResponse else {
            throw MockError.unwrapStubError
        }
        return try stubDataResponse.get()
    }

    public func setStubDataResponse(_ response: Result<(Data, URLResponse), Error>?) {
        stubDataResponse = response
    }
}
