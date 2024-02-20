//
//  APIEndpoint.swift
//  foodieTests
//
//  Created by Konrad Groschang on 20/02/2024.
//

import Foundation
@testable import foodie

extension APIEndpoint {

    static let test: APIEndpoint = .init(
        scheme: "https",
        host: "example.com",
        path: "/api/v1"
    )

}
