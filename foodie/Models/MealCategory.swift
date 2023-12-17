//
//  MealCategory.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//

import Foundation

struct MealCategory: IdentifiableObject {
    
    var id: String
    var name: String
    var imageUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageUrl = "strMealThumb"
    }
}

extension MealCategory {
    var previewUrl: URL? { //TODO: move to Networking+API extension
        imageUrl?.appendingPathComponent("preview")
    }
}

extension MealCategory: Mockable {
    static let mock: MealCategory = loadMock(from: "mealCategory")
}

