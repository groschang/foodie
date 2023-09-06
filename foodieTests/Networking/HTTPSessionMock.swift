//
//  NetworkSessionMock.swift
//  foodieTests
//
//  Created by Konrad Groschang on 04/09/2023.
//

import Foundation
@testable import foodie

class HTTPSessionMock: HTTPSession {

    enum HTTPSessionError: Swift.Error {
        case data
        case response
    }

    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {

        if let error { throw error }

        guard let data else { throw HTTPSessionError.data }
        guard let response else { throw HTTPSessionError.response }

        return (data, response)
    }
}
