//
//  Meals.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//

import Foundation

struct Meals: Codable, Hashable, Equatable {
    
    var items: [MealCategory]
    
    enum CodingKeys: String, CodingKey {
        case items = "meals"
    }
}

extension Meals: Identifiable {
    var id: Int { hashValue }
}

extension Meals: ContainsItems { }

extension Meals: StringIdentifier { }

extension Meals: Mockable {
    static let mock: Meals = loadMock(from: "meals")
}
