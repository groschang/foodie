//
//  Publisher.swift
//  foodie
//
//  Created by Konrad Groschang on 03/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Combine

extension Publisher {

    func asyncMap<T: Sendable>(
        _ transform: @escaping @Sendable (Output) async throws -> T
    ) -> Publishers.FlatMap<Future<T, Error>, Publishers.SetFailureType<Self, Error>>
    where Self.Failure == Never, Output: Sendable {
        self
            .setFailureType(to: Error.self)
            .asyncMap(transform)
    }

    func asyncMap<T: Sendable>(
        _ transform: @escaping @Sendable (Output) async throws -> T
    ) -> Publishers.FlatMap<Future<T, Error>, Self>
    where Self.Failure == Error, Output: Sendable {
        flatMap { value in
            Future { promise in

                let sendablePromise = SendablePromise(promise: promise)

                Task.detached {
                    do {
                        let output = try await transform(value)
                        sendablePromise.fulfill(.success(output))
                    } catch {
                        sendablePromise.fulfill(.failure(error))
                    }
                }
            }
        }
    }
}


private struct SendablePromise<T>: @unchecked Sendable {

    private let promise: (Result<T, Error>) -> Void

    init(promise: @escaping (Result<T, Error>) -> Void) {
        self.promise = promise
    }

    func fulfill(_ result: Result<T, Error>) {
        promise(result)
    }
}
