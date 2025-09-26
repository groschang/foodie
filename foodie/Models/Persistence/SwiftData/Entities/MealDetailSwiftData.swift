//
//  MealDetailSwiftData.swift
//  foodie
//
//  Created by Konrad Groschang on 08/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import SwiftData

@Model
class MealDetailSwiftData {

    @Attribute(.unique) var identifier: String
    var name: String
    var category: String?
    var area: String?
    var recipe: String?
    var imageURL: String? //TODO: type
    var youtubeURL: String? //TODO: type
    var source: String?
    @Relationship(deleteRule: .cascade, inverse: \IngredientSwiftData.mealDetail)
    var ingredients: [IngredientSwiftData]

    init(id: String, name: String, category: String? = nil, area: String? = nil, recipe: String? = nil, imageURL: String? = nil, youtubeURL: String? = nil, source: String? = nil, ingredients: [IngredientSwiftData] = []) {
        self.identifier = id
        self.name = name
        self.category = category
        self.area = area
        self.recipe = recipe
        self.imageURL = imageURL
        self.youtubeURL = youtubeURL
        self.source = source
        self.ingredients = ingredients
    }
}

//MARK: - Identifier

extension MealDetailSwiftData: Identifier { }

//MARK: - Object Mappable

extension MealDetailSwiftData {

    convenience init(_ meal: Meal) {
        self.init(id: meal.id,
                  name: meal.name,
                  category: meal.category,
                  area: meal.area,
                  recipe: meal.recipe,
                  imageURL: meal.imageURL?.description ,
                  youtubeURL: meal.youtubeURL?.description,
                  source: meal.source,
                  ingredients: meal.ingredients?.toIngredientEntities() ?? [])
    }
}

//MARK: - Entity Mappable

extension Meal {
    
    init(mealDetail entity: MealDetailSwiftData) {
        self.id = entity.identifier
        self.name = entity.name
        self.category = entity.category
        self.area = entity.area
        self.recipe = entity.recipe
        self.imageURL = URL(string: entity.imageURL)
        self.youtubeURL = URL(string: entity.youtubeURL)
        self.source = entity.source
        self.ingredients = entity.ingredients.toIngredients()
    }
}

//MARK: - Array

extension Array where Element == MealDetailSwiftData {

    func toMeals() -> [Meal]? {
        self.map(Meal.init)
    }
}
