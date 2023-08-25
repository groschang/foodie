//
//  DIContainer.swift
//  foodie
//
//  Created by Konrad Groschang on 15/04/2023.
//

import Foundation

typealias FactoryClosure = (DIContainer) -> AnyObject

protocol DICProtocol {
    func register<Service>(type: Service.Type, factoryClosure: @escaping FactoryClosure)
    func resolve<Service>(type: Service.Type) -> Service?
}


class DIContainer: DICProtocol {

    var services = Dictionary<String, FactoryClosure>()

    func register<Service>(type: Service.Type, factoryClosure: @escaping FactoryClosure) {
        services["\(type)"] = factoryClosure
    }

    func resolve<Service>(type: Service.Type) -> Service? {
        return services["\(type)"]?(self) as? Service
    }
}
