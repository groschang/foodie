//
//  APIClient2.swift
//  foodie
//
//  Created by Konrad Groschang on 18/09/2023.
//

import Foundation

//extension HTTPSession {
//    func dataTaskPublisher(for url: URL) -> URLSession.DataTaskPublisher
//}

class APIClient2: HTTPClient {

    private let enviroment: APIEndpoint

    private let requestBuilder: RequestBuilder

    private let session = URLSession.extended

    private let decoder: JSONDecoder

    init(
        enviroment: APIEndpoint = .production,
        requestBuilder: RequestBuilder.Type = URLRequestBuilder.self,
        decoder: JSONDecoder = .init()
    ) {
        self.enviroment = enviroment
        self.requestBuilder = requestBuilder.init(enviroment: enviroment)
        self.decoder = decoder
    }

    func process<T: Decodable>(_ request: Request<T>) async throws -> T {
        do {
            let urlRequest = try requestBuilder.build(for: request)
//            let (data, response) = try await download(urlRequest)
            let object: T = try await download(urlRequest)
//            try validate(response)
//            let object: T = try decode(data)
//            NetworkLogger.log(request: urlRequest)
//            NetworkLogger.log(response: response)
//            NetworkLogger.log(data: data)
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

    private func download<T: Decodable>(_ request: URLRequest) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in

//            let publisher =
         _ =
            session
                .dataTaskPublisher(for: request)
                .retry(3)
                .mapError { APIError($0) }
                .tryMap {
                    try Self.validate($0.response)
                    return $0.data
                }
                .decode(type: T.self, decoder: decoder)
                .mapError { APIError($0) }
//                .eraseToAnyPublisher()

//            publisher
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
//
//    private class func validate(_ response: URLResponse) throws {
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw APIError.noResponse
//        }
//
//        switch httpResponse.statusCode {
//        case HttpStatusCode.successful:
//            return
//        case HttpStatusCode.clientError:
//            throw APIError.client(httpResponse.statusCode)
//        default:
//            throw APIError.unexpected(httpResponse.statusCode)
//        }
//    }

//    private func decode<T: Decodable>(_ data: Data) throws -> T {
//        try decoder.decode(T.self, from: data)
//    }
}

