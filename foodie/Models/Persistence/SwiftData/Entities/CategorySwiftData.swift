//
//  CategorySwiftData.swift
//  foodie
//
//  Created by Konrad Groschang on 08/01/2024.
//

import Foundation
import SwiftData

@Model
final class CategorySwiftData {

    @Attribute(.unique) var identifier: String
    var name: String
    var desc: String
    var imageURL: String
    @Relationship(deleteRule: .cascade, inverse: \MealCategorySwiftData.category)
    var mealCategories: [MealCategorySwiftData]

    init(id: String, name: String, desc: String, imageURL: String, mealCategories: [MealCategorySwiftData] = []) {
        self.identifier = id
        self.name = name
        self.desc = desc
        self.imageURL = imageURL
        self.mealCategories = mealCategories
    }
}

// MARK: Identifier

extension CategorySwiftData: Identifier { }

//MARK: Object Mappable

extension CategorySwiftData {

    convenience init(_ category: Category) {
        self.init(id: category.id,
                  name: category.name,
                  desc: category.imageUrl.toString(),
                  imageURL: category.description)
    }
}

//MARK: Entity Mappable

extension Category {

    init(category entity: CategorySwiftData) {
        self.id = entity.identifier
        self.name = entity.name
        self.imageUrl = URL(string: entity.imageURL)
        self.description = entity.desc
        print("XXX: \(entity.id)")
    }
}

//MARK: Array

extension Array where Element == CategorySwiftData {

    func toCategories() -> Categories? {
        let items = self.map(Category.init)
        return Categories(items: items)
    }
}


