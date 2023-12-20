//
//  Endpoint.swift
//  Coctail
//
//  Created by Konrad Groschang on 07/12/2022.
//

import Foundation

struct Endpoint {
    let path: String
    var queryItems: [URLQueryItem]?
    
    init(path: String, queryItems: [URLQueryItem]? = nil) {
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

    static func ingredientImage(name: String, small: Bool = false) -> Endpoint {
        Endpoint(
            path: "/images/ingredients/\(name)\(small ? "-Small" : "" ).png"
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
