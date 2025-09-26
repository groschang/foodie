//
//  URLRequestBuilder.swift
//  foodie
//
//  Created by Konrad Groschang on 07/09/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

enum RequestError: Error {
    case invalidURL(String)
}


protocol RequestBuilder: Sendable {
    init(enviroment: APIEndpoint)

    func build<T>(for request: Request<T>) async throws -> URLRequest
}


struct URLRequestBuilder: RequestBuilder {

    private let enviroment: APIEndpoint

    init(enviroment: APIEndpoint) {
        self.enviroment = enviroment
    }

    func build<T>(for request: Request<T>) async throws(RequestError) -> URLRequest {
        guard let url = buildURL(for: request.endpoint, enviroment: enviroment) else {
            throw RequestError.invalidURL("\(request.endpoint)")
        }
        return buildURLRequest(url: url, headers: request.headers)
    }

    private func buildURL(for endpoint: Endpoint, enviroment: APIEndpoint) -> URL? {
        var components = URLComponents()
        components.scheme = enviroment.scheme
        components.host = enviroment.host
        components.path = enviroment.path + endpoint.path
        components.queryItems = endpoint.queryItems
        return components.url
    }

    typealias Headers = [String : String]

    private func buildURLRequest(url: URL, headers: Headers? = nil) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        return urlRequest
    }
}
