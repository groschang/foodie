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
        URL(
            enviroment: .production,
            endpoint: .ingredientImage(name: name)
        )
    }
    
    var smallImageUrl: URL? {
        URL(
            enviroment: .production,
            endpoint: .smallIngredientImage(name: name)
        )
    }

    private func imageUrl(enviroment: APIEndpoint = .production, endpoint: Endpoint) -> URL? {
        let components = URLComponents(enviroment: enviroment,
                                       endpoint: endpoint)
        return components.url
    }

}
