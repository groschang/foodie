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

    static private let Timeout = 50.0
    
    private let requestTimeout = TimeInterval(Timeout)

    private var enviroment: APIEndpoint

    private var requestBuilder: RequestBuilder
    
    private lazy var decoder = JSONDecoder()
    
    private lazy var session: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(requestTimeout)
        let session = URLSession(configuration: sessionConfig)
        return session
    }()

    init(enviroment: APIEndpoint = .production) {
        self.enviroment = enviroment
        self.requestBuilder = URLRequestBuilder(enviroment: enviroment)
    }
    
    func process<T: Decodable>(_ request: Request<T>) async throws -> T {
        do {
            let urlRequest = try requestBuilder.build(for: request)
            let (data, response) = try await session.data(for: urlRequest)
            NetworkLogger.log(request: urlRequest)
            NetworkLogger.log(response: response)
            NetworkLogger.log(data: data)
            try validate(response: response)
            return try decodeResponse(data: data)
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


