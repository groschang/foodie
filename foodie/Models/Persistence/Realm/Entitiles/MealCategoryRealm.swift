//
//  MealCategoryRealm.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import RealmSwift

class MealCategoryRealm: Object {

    @Persisted(primaryKey: true) var identifier: String
    @Persisted var name: String
    @Persisted var imageUrl: String
    @Persisted var category: CategoryRealm?

    convenience init(
        id: String,
        name: String,
        imageUrl: String,
        category: CategoryRealm? = nil
    ) {
        self.init()
        self.identifier = id
        self.name = name
        self.imageUrl = imageUrl
        self.category = category
    }
}

//MARK: Identifier

extension MealCategoryRealm: Identifier { }

//MARK: Object Mappable

extension MealCategoryRealm {

    convenience init(_ mealCategory: MealCategory) {
        self.init(
            id: mealCategory.id,
            name: mealCategory.name,
            imageUrl: mealCategory.imageUrl.toString()
        )
    }

    convenience init(_ mealCategory: MealCategory, category: CategoryRealm) {
        self.init(mealCategory)
        self.category = category
    }
}

//MARK: Entity Mappable

extension MealCategory {

    init(mealCategory entity: MealCategoryRealm) {
        self.id = entity.identifier
        self.name = entity.name
        self.imageUrl = URL(string: entity.imageUrl)
    }
}

//MARK: Array

extension Array where Element == MealCategoryRealm {

    /// Transforms `MealCategoryRealm` objects array into `Meals` object or returns nil if `MealCategory` array is empty
    /// - Note: Used mainly for backward compability with databases (some of them returns
    /// empty arrays which may cause impact on bussines logic of user interface)
    /// - Returns: `Meals` object
    func toMeals() -> Meals? {
        guard self.isNotEmpty else { return nil }
        let items = self.map(MealCategory.init)
        return Meals(items: items)
    }
}

//MARK: Results

extension Results where Element == MealCategoryRealm {

    /// Transforms `MealCategoryRealm` objects `Result` into `Meals` object or returns nil if `MealCategory` array is empty
    /// - Note: Used mainly for backward compability with databases (some of them returns
    /// empty arrays which may cause impact on bussines logic of user interface)
    /// - Returns: `Meals` object
    func toMeals() -> Meals? {
        guard self.isEmpty == false else { return nil }
        let items: [MealCategory] = self.map(MealCategory.init)
        return Meals(items: items)
    }
}
