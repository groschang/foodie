//
//  IngredientRealm.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import RealmSwift

final class IngredientRealm: Object {

    @Persisted var name: String
    @Persisted var measure: String
    @Persisted var mealDetail: MealDetailRealm?

    convenience init(
        name: String,
        measure: String,
        mealDetail: MealDetailRealm? = nil
    ) {
        self.init()
        self.name = name
        self.measure = measure
        self.mealDetail = mealDetail
    }
}

//MARK: - Object Mappable

extension IngredientRealm {

    convenience init(_ ingredient: Ingredient) {
        self.init(
            name: ingredient.name,
            measure: ingredient.measure
        )
    }
}

//MARK: - Entity Mappable

extension Ingredient {

    init(ingredient entity: IngredientRealm) {
        self.name = entity.name
        self.measure = entity.measure
    }
}

//MARK: - Array

extension Array where Element == Ingredient {
    func toIngredientEntities() -> List<IngredientRealm>? {
        let list = List<IngredientRealm>()
        list.append(objectsIn: self.map(IngredientRealm.init))
        return list
    }
}

extension Array where Element == IngredientRealm {

    /// Transforms `IngredientRealm` objects array into `Ingredient` array or returns nil if array is empty
    /// - Note: Used mainly for backward compability with databases (some of them returns
    /// empty arrays which may cause impact on bussines logic of user interface)
    /// - Returns: `Ingredient` objects array
    func toIngredients() -> [Ingredient]? {
        guard self.isNotEmpty else { return nil }
        return map(Ingredient.init)
    }
}

//MARK: - List

extension List where Element == IngredientRealm {

    /// Transforms `IngredientRealm` objects list into `Ingredient` objects array or returns nil if list is empty
    /// - Note: Used mainly for backward compability with databases (some of them returns
    /// empty arrays which may cause impact on bussines logic of user interface)
    /// - Returns: `Ingredient` objects array
    func toIngredients() -> [Ingredient]? {
        guard self.isEmpty == false else { return nil }
        return map(Ingredient.init)
    }
}
