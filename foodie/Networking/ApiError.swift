//
//  ApiError.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//

import Foundation

enum ApiError: Error, LocalizedError {
    
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
            description = "request failed"

            if let code {
                description = " with code \(code)"
            }

            if let response,
               let errorResponse = response.toObject(ErrorResponse.self),
               let errorCode = errorResponse.errorCode {
                description += ": \(errorCode.localized)"
            }
            return description
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
