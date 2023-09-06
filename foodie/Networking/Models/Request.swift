//
//  Request.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//

import Foundation

enum RequestError: Error {
    case invalidURL(String)
}

protocol RequestBuilder {
    init(enviroment: APIEndpoint)

    func build<T>(for request: Request<T>) throws -> URLRequest
    //    func buildURLRequest()  -> URLRequest
//    func buildURLRequest(for enviroment: APIEndpoint) throws -> URLRequest
}

//protocol Requestable2 {
//    func buildURLRequest()  -> URLRequest
//}

struct URLRequestBuilder: RequestBuilder {

    private let enviroment: APIEndpoint

    init(enviroment: APIEndpoint) {
        self.enviroment = enviroment
    }

    func build<T>(for request: Request<T>) throws -> URLRequest {
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

//    func buildURL(for endpoint: Endpoint, enviroment: APIEndpoint) -> URL? {
//        var components = URLComponents()
//        components.scheme = enviroment.scheme
//        components.host = enviroment.host
//        components.path = enviroment.path + endpoint.path
//        components.queryItems = endpoint.queryItems
//        return components.url
//    }

    typealias Headers = [String : String]

    private func buildURLRequest(url: URL, headers: Headers? = nil) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        return urlRequest
    }
}




class Request<T:Codable> {
    
//    private let requestBuilder = RequestBuilder()
    
     let endpoint: Endpoint
     let headers: [String: String]?
    
    init(endpoint: Endpoint, headers: [String: String]? = nil) {
        self.endpoint = endpoint
        self.headers = headers
    }

//    func buildURLRequest(for enviroment: APIEndpoint) throws -> URLRequest {
//        guard let url = requestBuilder.buildURL(for: endpoint, enviroment: enviroment) else {
//            throw RequestError.invalidURL(endpoint.path)
//        }
//        return requestBuilder.buildURLRequest(url: url, headers: headers)
//    }

    //    func buildURLRequest(for enviroment: APIEndpoint) throws -> URLRequest {
    //
    //    }
}


extension Request: CustomStringConvertible {
    var description: String {
        String(describing: endpoint.path)
    }
}
