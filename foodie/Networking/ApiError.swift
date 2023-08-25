//
//  ApiError.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//

import Foundation

enum ApiError: LocalizedError {
    
    case badURL(_ url: String)
    case serverError(_ error: String)
    case noResponse
    case invalidJSON(_ error: String)
    case requestFailed(statusCode: Int?, response: Data?)
    case clientError(_ code: Int)
    case unexpectedStatusCode(_ code: Int)
    case unknown
    
    var errorDescription: String? {
        var description: String

        switch self {
        case .badURL(let url):
            description = "Bad url \(url)"
        case .serverError(let error):
            description = "server error \(error)"
        case .noResponse:
            description = "no repsonse"
        case .invalidJSON(let error):
            description = "invalid json \(error)"
        case .requestFailed(let code, let response):
            if let response,
               let errorResponse = response.toObject(ErrorResponse.self),
               let errorCode = errorResponse.errorCode {
                description = "request failed \(errorCode.localized)"
            }
            description = "request failed \(String(describing: code))"
        case .clientError(let code):
            description = "client error code: \(code)"
        case .unexpectedStatusCode(let code):
            description = "unexpdected status code: \(code)"
        case .unknown:
            description = "unknown"
        }

        return description
    }
}


extension DecodingError {
    
    var verbose: String { //TODO: check
        var description: String

        switch self {
        case .typeMismatch(let key, let value):
            description = makeDescription(error: self, key: key, value: value)
        case .valueNotFound(let key, let value):
            description = makeDescription(error: self, key: key, value: value)
        case .keyNotFound(let key, let value):
            description = makeDescription(error: self, key: key, value: value)
        case .dataCorrupted(let key):
            description = makeDescription(error: self, key: key)
        default:
            description = makeDescription(error: self)
        }

        return description
    }
    
    func makeDescription(error: DecodingError, key: Any? = nil, value: DecodingError.Context? = nil) -> String {

        var description = "\(error.localizedDescription)"
        if let key {
            description += "\nType: \(key)"
        }
        if let value {
            description += "\nContext: \(value.debugDescription)"
            description += "\nValue: \(value)"
        }

        return description
    }
    
}
