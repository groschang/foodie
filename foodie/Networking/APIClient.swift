//
//  APIClient.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//

import Foundation

protocol HTTPClient {
    func process<T: Decodable>(_ request: Request<T>) async throws -> T
}

class APIClient: HTTPClient { //TODO: rename? NetworkClient?

    private let enviroment: APIEndpoint

    private let requestBuilder: RequestBuilder

    private let session: HTTPSession
    
    private let decoder: JSONDecoder

    init(
        enviroment: APIEndpoint = .production,
        session: HTTPSession = URLSession.extended,
        requestBuilder: RequestBuilder.Type = URLRequestBuilder.self,
        decoder: JSONDecoder = .init()
    ) {
        self.enviroment = enviroment
        self.requestBuilder = requestBuilder.init(enviroment: enviroment)
        self.session = session
        self.decoder = decoder
    }
    
    func process<T: Decodable>(_ request: Request<T>) async throws -> T {
        do {
            let urlRequest = try requestBuilder.build(for: request)
            let (data, response) = try await session.data(for: urlRequest)
            try validate(response: response)
            let object: T = try decodeResponse(data: data)
            NetworkLogger.log(request: urlRequest)
            NetworkLogger.log(response: response)
            NetworkLogger.log(data: data)
            return object

        } catch let error as RequestError {

            Logger.log(error, onLevel: .error)
            throw ApiError.badURL(error.localizedDescription + request.description)

        } catch let error as DecodingError {

            Logger.log(error.verbose, onLevel: .error)
            throw ApiError.invalidJSON(error.verbose)

        } catch let error as NSError {

            guard
                error.domain == NSURLErrorDomain,
                error.code == NSURLErrorCancelled
            else {
                Logger.log("Api \(error)", onLevel: .error)
                throw ApiError.unknown
            }
            Logger.log(error, onLevel: .error)
            throw CancellationError()

        } catch {

            Logger.log(error, onLevel: .error)
            throw ApiError.unknown
        }
    }
    
    private func validate(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.noResponse
        }
        
        switch httpResponse.statusCode {
        case HttpStatusCode.successful:
            return
        case HttpStatusCode.clientError:
            throw ApiError.clientError(httpResponse.statusCode)
        default:
            throw ApiError.unexpectedStatusCode(httpResponse.statusCode)
        }
    }
    
    private func decodeResponse<T: Decodable>(data: Data) throws -> T {
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}

