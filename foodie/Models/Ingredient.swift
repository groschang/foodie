//
//  Ingredient.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//

import Foundation

struct Ingredient: Codable, Hashable, Equatable {
    
    var name: String
    var measure: String
    
}

extension Ingredient: Comparable {
    static func < (lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.name < rhs.name
    }
}

extension Ingredient {
    var imageUrl: URL? { //TODO: use URLRequestBuilder
        getImageUrl(endpoint: .ingredientImage(name: name))
    }

    var smallImageUrl: URL? {
        getImageUrl(endpoint: .ingredientImage(name: name, small: true))
    }

    private func getImageUrl(enviroment: APIEndpoint = .production, endpoint: Endpoint) -> URL? {
        var components = URLComponents()
        components.scheme = enviroment.scheme
        components.host = enviroment.host
        components.path = endpoint.path
        return components.url
    }
}
