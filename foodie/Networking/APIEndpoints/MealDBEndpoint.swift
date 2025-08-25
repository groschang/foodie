//
//  MealDBEndpoint.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import SwiftUI

enum MealDBEndpoint {
    
    class CategoriesRequest: Request<Categories>, @unchecked Sendable {
        init() {
            super.init(endpoint: .categories)
        }
    }
    
    class MealsRequest: Request<Meals>, @unchecked Sendable {
        init(category: String) {
            let category = category.replacingOccurrences(of: " ", with: "_")
            super.init(endpoint: .meals(category: category))
        }
    }

    class MealRequest: Request<Meal>, @unchecked Sendable {
        init(id: String) {
            super.init(endpoint: .meal(id: id))
        }
    }

    class MealRandomRequest: Request<Meal>, @unchecked Sendable {
        init() {
            super.init(endpoint: .randomMeal)
        }
    }
}
