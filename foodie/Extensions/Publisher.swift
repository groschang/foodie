//
//  Publisher.swift
//  foodie
//
//  Created by Konrad Groschang on 03/03/2024.
//

import Combine

extension Publisher {

    func asyncMap<T>(
        _ transform: @escaping (Output) async throws -> T
    ) -> Publishers.FlatMap< Future<T, Error>, Publishers.SetFailureType<Self, Error> >
    where Self.Failure == Never {
        self
            .setFailureType(to: Error.self)
            .asyncMap(transform)
    }

    func asyncMap<T>(
        _ transform: @escaping (Output) async throws -> T
    ) -> Publishers.FlatMap< Future<T, Error>, Self >
    where Self.Failure == Error {
        flatMap { value in
            Future { promise in
                Task {
                    do {
                        let output = try await transform(value)
                        promise(.success(output))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }

}
