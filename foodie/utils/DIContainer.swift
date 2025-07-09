//
//  DIContainer.swift
//  foodie
//
//  Created by Konrad Groschang on 15/04/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

typealias FactoryClosure = @Sendable (DIContainer) async -> Sendable

protocol DICProtocol: AnyObject {
    func register<Service: Sendable>(_ type: Service.Type, factoryClosure: @escaping FactoryClosure) async
    func resolve<Service: Sendable>(_ type: Service.Type) async -> Service?
}

actor DIContainer: DICProtocol {

    private var services: [String: @Sendable () async -> any Sendable] = [:]

    func register<Service: Sendable>(_ type: Service.Type, factoryClosure: @escaping FactoryClosure) {
        let key = String(describing: type)
        services[key] = { await factoryClosure(self) }
    }

    func resolve<Service: Sendable>(_ type: Service.Type) async -> Service? {
        let key = String(describing: type)
        guard let factory = services[key] else { return nil }
        return await factory() as? Service
    }
}
