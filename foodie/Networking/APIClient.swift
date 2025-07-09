//
//  APIClient.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

protocol HTTPClient: Sendable {
    func process<T: Decodable>(_ request: Request<T>) async throws -> T
}

final class APIClient: HTTPClient {

    private let requestBuilder: RequestBuilder

    private let session: HTTPSession
    
    private let decoder: JSONDecoder

    init(
        session: HTTPSession = URLSession.extended,
        requestBuilder: RequestBuilder = URLRequestBuilder(enviroment: .production),
        decoder: JSONDecoder = .init()
    ) {
        self.requestBuilder = requestBuilder
        self.session = session
        self.decoder = decoder
    }
    
    func process<T: Decodable>(_ request: Request<T>) async throws -> T {
        
        do {

            let urlRequest = try requestBuilder.build(for: request)
            let (data, response) = try await session.data(for: urlRequest)
            try validate(response)
            let object: T = try decode(data)
            NetworkLogger.log(request: urlRequest)
            NetworkLogger.log(response: response)
            NetworkLogger.log(data: data)
            return object

        } catch let error as APIError {

            Logger.log(error, onLevel: .error)
            throw error

        } catch let error as RequestError {

            Logger.log(error, onLevel: .error)
            throw APIError.badURL(error.localizedDescription + request.description)

        } catch let error as DecodingError {

            Logger.log(error.verbose, onLevel: .error)
            throw APIError.parsing(error.verbose)

        } catch let error as NSError {

            guard
                error.domain == NSURLErrorDomain,
                error.code == NSURLErrorCancelled
            else {
                Logger.log("API \(error)", onLevel: .error)
                throw APIError.unknown
            }
            Logger.log(error, onLevel: .error)
            throw CancellationError()

        } catch {

            Logger.log(error, onLevel: .error)
            throw APIError.unknown
        }
    }
    
    private func validate(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.noResponse
        }
        
        switch httpResponse.statusCode {
        case HttpStatusCode.successful:
            return
        case HttpStatusCode.clientError:
            throw APIError.client(httpResponse.statusCode)
        case HttpStatusCode.serverError:
            throw APIError.server(httpResponse.description)
        default:
            throw APIError.unexpected(httpResponse.statusCode)
        }
    }
    
    private func decode<T: Decodable>(_ data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}

