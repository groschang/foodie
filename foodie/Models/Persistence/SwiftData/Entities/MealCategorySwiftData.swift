//
//  MealCategorySwiftData.swift
//  foodie
//
//  Created by Konrad Groschang on 08/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import SwiftData

@Model
class MealCategorySwiftData {

    @Attribute(.unique) var identifier: String
    var name: String
    var imageUrl: String
    var category: CategorySwiftData?

    init(id: String, name: String, imageUrl: String, category: CategorySwiftData? = nil) {
        self.identifier = id
        self.name = name
        self.imageUrl = imageUrl
        self.category = category
    }
}

//MARK: Identifier

extension MealCategorySwiftData: Identifier { }

//MARK: Object Mappable

extension MealCategorySwiftData {

    convenience init(_ mealCategory: MealCategory) {
        self.init(id: mealCategory.id,
                  name: mealCategory.name,
                  imageUrl: mealCategory.imageUrl.toString())
    }

    convenience init(_ mealCategory: MealCategory, category: CategorySwiftData) {
        self.init(mealCategory)
        self.category = category
    }
}

//MARK: Entity Mappable

extension MealCategory {

    init(mealCategory entity: MealCategorySwiftData) {
        self.id = entity.identifier
        self.name = entity.name
        self.imageUrl = URL(string: entity.imageUrl)
    }
}

//MARK: Array

extension Array where Element == MealCategorySwiftData {

    func toMeals() -> Meals? {
        let items = self.map(MealCategory.init)
        return Meals(items: items)
    }
}
