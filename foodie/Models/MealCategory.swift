//
//  MealCategory.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
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

// MARK: - Sutbs

extension MealCategory: Stubable {
    static let stub: MealCategory = loadStub(from: "mealCategory")
}

