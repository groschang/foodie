//
//  APIEndpoint.swift
//  foodie
//
//  Created by Konrad Groschang on 31/05/2023.
//

import Foundation

struct APIEndpoint {
    let scheme: String
    let host: String
    let path: String
}

extension APIEndpoint {
    
    static let production: APIEndpoint = .init(
        scheme: "https",
        host: "themealdb.com",
        path: "/api/json/v1/1"
    )
}
