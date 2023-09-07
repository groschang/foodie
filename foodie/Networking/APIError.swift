//
//  APIError.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//

import Foundation

enum APIError: Error, LocalizedError {
    
    case badURL(_ url: String)
    case server(_ error: String)
    case noResponse
    case parsing(_ error: String)
    case requestFailed(code: Int?, response: Data?)
    case client(_ code: Int)
    case unexpected(_ code: Int)
    case unknown
    
    var errorDescription: String? {
        var description: String

        switch self {
        case .badURL(let url):
            description = "Bad url \(url)"
        case .server(let error):
            description = "Server error \(error)"
        case .noResponse:
            description = "No repsonse"
        case .parsing(let error):
            description = "Invalid json \(error)"
        case .requestFailed(let code, let response):
            description = "Request failed"

            if let code {
                description = " with code \(code)"
            }

            if let response,
               let errorResponse = response.toObject(ErrorResponse.self),
               let errorCode = errorResponse.errorCode {
                description += ": \(errorCode.localized)"
            }
            return description
        case .client(let code):
            description = "Client error code: \(code)"
        case .unexpected(let code):
            description = "Unexpdected status code: \(code)"
        case .unknown:
            description = "Unknown"
        }

        return description
    }
}
