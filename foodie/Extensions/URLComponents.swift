//
//  URLComponents.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2024.
//

import Foundation

extension URLComponents {

    init(enviroment: APIEndpoint) {
        self.init()
        self.scheme = enviroment.scheme
        self.host = enviroment.host
    }

    init(enviroment: APIEndpoint, endpoint: Endpoint) {
        self.init(enviroment: enviroment)
        self.path = endpoint.path
    }
}
