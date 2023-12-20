//
//  MealDBEndpoint.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//

import Foundation
import SwiftUI

struct MealDBEndpoint {
    
    class CategoriesRequest: Request<Categories> {
        init() {
            super.init(endpoint: .categories)
        }
    }
    
    class MealsRequest: Request<Meals> {
        init(category: String) {
            let category = category.replacingOccurrences(of: " ", with: "_")
            super.init(endpoint: .meals(category: category))
        }
    }

    class MealRequest: Request<Meal> {
        init(id: String) {
            super.init(endpoint: .meal(id: id))
        }
    }

    class MealRandomRequest: Request<Meal> {
        init() {
            super.init(endpoint: .randomMeal)
        }
    }
}
