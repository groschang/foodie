//
//  IngredientSwiftData.swift
//  foodie
//
//  Created by Konrad Groschang on 08/01/2024.
//

import Foundation
import SwiftData

@Model
final class IngredientSwiftData {

//    @Attribute(.unique) 
    var name: String
    var measure: String
    var mealDetail: MealDetailSwiftData?

    init(name: String, measure: String, mealDetail: MealDetailSwiftData? = nil) {
        self.name = name
        self.measure = measure
        self.mealDetail = mealDetail
    }
}

//MARK: Object Mappable

extension IngredientSwiftData {

    convenience init(_ ingredient: Ingredient) {
        self.init(name: ingredient.name,
                  measure: ingredient.measure)
    }
}

//MARK: Entity Mappable

extension Ingredient {
    
    init(ingredient entity: IngredientSwiftData) {
        self.name = entity.name
        self.measure = entity.measure
    }
}

//MARK: Array

extension Array where Element == Ingredient {
    func toIngredientEntities() -> [IngredientSwiftData]? {
        map(IngredientSwiftData.init)
    }
}

extension Array where Element == IngredientSwiftData {

    func toIngredients() -> [Ingredient] {
        map(Ingredient.init)
    }
}
