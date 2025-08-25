//
//  APICombineClient.swift
//  foodie
//
//  Created by Konrad Groschang on 18/09/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

final class APICombineClient: HTTPClient {

    private let enviroment: APIEndpoint

    private let requestBuilder: RequestBuilder

    private let session = URLSession.extended

    init(
        enviroment: APIEndpoint = .production,
        requestBuilder: RequestBuilder.Type = URLRequestBuilder.self
    ) {
        self.enviroment = enviroment
        self.requestBuilder = requestBuilder.init(enviroment: enviroment)
    }

    func process<T: Decodable & Sendable>(_ request: Request<T>) async throws -> T {
        do {

            let urlRequest = try await requestBuilder.build(for: request)
            let object: T = try await download(urlRequest)

            return object

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

    private func download<T: Decodable & Sendable>(_ request: URLRequest) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            let _ = session //TODO: returns any publisher insead t ?
                .dataTaskPublisher(for: request)
                .retry(3)
                .mapError { APIError($0) }
                .tryMap {
                    try Self.validate($0.response)
                    return $0.data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { APIError($0) }
                .sink {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                } receiveValue: {
                    continuation.resume(returning: $0)
                }
        }
    }

    private class func validate(_ response: URLResponse) throws {
        if let error = APIError(response) { throw error }
    }
}
