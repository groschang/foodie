//
//  NetworkSessionMock.swift
//  foodieTests
//
//  Created by Konrad Groschang on 04/09/2023.
//

import Foundation
@testable import foodie

class HTTPSessionMock: HTTPSession {

    public var stubDataResponse: Result<(Data, URLResponse), Error>?
    public var didData: (() -> Void)?
    public var dataCallCount = 0

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        defer { didData?() }
        dataCallCount += 1
        return try stubDataResponse!.get()
    }

}
