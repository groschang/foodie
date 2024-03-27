//
//  DIContainer.swift
//  foodie
//
//  Created by Konrad Groschang on 15/04/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

typealias FactoryClosure = (DIContainer) -> AnyObject

protocol DICProtocol {
    func register<Service>(_ type: Service.Type, factoryClosure: @escaping FactoryClosure)
    func resolve<Service>(_ type: Service.Type) -> Service?
}

final class DIContainer: DICProtocol {

    var services = Dictionary<String, AnyObject>()

    func register<Service>(_ type: Service.Type, factoryClosure: @escaping FactoryClosure) {
        services["\(type)"] = factoryClosure(self)
    }

    func resolve<Service>(_ type: Service.Type) -> Service? {
        services["\(type)"] as? Service
    }
}
