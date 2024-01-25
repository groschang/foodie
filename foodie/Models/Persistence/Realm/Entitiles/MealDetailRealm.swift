//
//  MealDetailRealm.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2024.
//

import Foundation
import RealmSwift

final class MealDetailRealm: Object {

    @Persisted(primaryKey: true) var identifier: String
    @Persisted var name: String
    @Persisted var category: String?
    @Persisted var area: String?
    @Persisted var recipe: String?
    @Persisted var imageURL: String? //TODO: type
    @Persisted var youtubeURL: String? //TODO: type
    @Persisted var source: String?
    @Persisted var ingredients: List<IngredientRealm>

    convenience init(
        id: String,
        name: String,
        category: String? = nil,
        area: String? = nil,
        recipe: String? = nil,
        imageURL: String? = nil,
        youtubeURL: String? = nil,
        source: String? = nil,
        ingredients: List<IngredientRealm>? = nil
    ) {
        self.init()
        self.identifier = id
        self.name = name
        self.category = category
        self.area = area
        self.recipe = recipe
        self.imageURL = imageURL
        self.youtubeURL = youtubeURL
        self.source = source
        self.ingredients = ingredients ?? List()
    }
}

//MARK: Identifier

extension MealDetailRealm: Identifier { }

//MARK: Object Mappable

extension MealDetailRealm {

    convenience init(_ meal: Meal) {
        self.init(
            id: meal.id,
            name: meal.name,
            category: meal.category,
            area: meal.area,
            recipe: meal.recipe,
            imageURL: meal.imageURL?.description ,
            youtubeURL: meal.youtubeURL?.description,
            source: meal.source,
            ingredients: meal.ingredients?.toIngredientEntities()
        )
    }
}

//MARK: Entity Mappable

extension Meal {

    init(mealDetail entity: MealDetailRealm) {
        self.id = entity.identifier
        self.name = entity.name
        self.category = entity.category
        self.area = entity.area
        self.recipe = entity.recipe
        self.imageURL = URL(string: entity.imageURL)
        self.youtubeURL = URL(string: entity.youtubeURL)
        self.source = entity.source
        let ingredients = entity.ingredients.toIngredients()
        self.ingredients = ingredients
    }
}

//MARK: Array

extension Array where Element == MealDetailRealm {

    /// Transforms array with `MealDetailRealm` objects array into `Meal` objects array or returns nil if array is empty
    /// - Note: Used mainly for backward compability with databases (some of them returns
    /// empty arrays which may cause impact on bussines logic of user interface)
    /// - Returns: `Meal` objects array
    func toMeals() -> [Meal]? {
        guard self.isNotEmpty else { return nil }
        return self.map(Meal.init)
    }
}
