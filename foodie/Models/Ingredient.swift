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
