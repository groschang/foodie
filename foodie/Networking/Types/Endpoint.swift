//
//  Endpoint.swift
//  Coctail
//
//  Created by Konrad Groschang on 07/12/2022.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

struct Endpoint: Sendable {

    let path: String
    var queryItems: [URLQueryItem]?
    
    init(path: String, queryItems: [URLQueryItem]? = nil) {
        /// Every path must starts with directory slash "/" sign
        assert(path.starts(with: "/"), "Path must starts with '/' sign")
        /// Every path must not ends with directory slash "/" sign
        assert(path.hasSuffix("/") == false, "Path must not ends with '/' sign")
        self.path = path
        self.queryItems = queryItems
    }
}


extension Endpoint {
    
    static let categories: Endpoint = .init(
        path: "/categories.php"
    )
    
    static func meals(category: String) -> Endpoint {
        Endpoint(
            path: "/filter.php",
            queryItems: [
                URLQueryItem(name: "c", value: category)
            ]
        )
    }

    static func meal(id: String) -> Endpoint {
        Endpoint(
            path: "/lookup.php",
            queryItems: [
                URLQueryItem(name: "i", value: id)
            ]
        )
    }

    static let randomMeal = Endpoint(path: "/random.php")

    static func ingredientImage(name: String) -> Endpoint {
        Endpoint(
            path: "/images/ingredients/\(name).png"
        )
    }

    static func smallIngredientImage(name: String) -> Endpoint {
        Endpoint(
            path: String.smallImagePath("/images/ingredients/\(name).png")!
        )
    }
}


extension Endpoint: CustomStringConvertible {

    var description: String {
        var output = path

        if let queryItems {
            output += queryItems.reduce("") {
                $0 + ",\($1.name)=\(String(describing: $1.value))"
            }
        }

        return output
    }
}
