//
//  CategoryRealm.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import RealmSwift

final class CategoryRealm: Object {

    @Persisted(primaryKey: true) var identifier: String
    @Persisted var name: String
    @Persisted var desc: String
    @Persisted var imageURL: String
    @Persisted var mealCategories: List<MealCategoryRealm>

    convenience init(
        id: String,
        name: String,
        desc: String,
        imageURL: String,
        mealCategories: List<MealCategoryRealm> = List<MealCategoryRealm>()
    ) {
        self.init()
        self.identifier = id
        self.name = name
        self.desc = desc
        self.imageURL = imageURL
        self.mealCategories = mealCategories
    }
}

// MARK: - Identifier

extension CategoryRealm: Identifier { }

//MARK: - Object Mappable

extension CategoryRealm {

    convenience init(_ category: Category) {
        self.init(
            id: category.id,
            name: category.name,
            desc: category.description,
            imageURL: category.imageUrl.toString()
        )
    }
}

//MARK: - Entity Mappable

extension Category {

    init(category entity: CategoryRealm) {
        self.id = entity.identifier
        self.name = entity.name
        self.imageUrl = URL(string: entity.imageURL)
        self.description = entity.desc
    }
}

//MARK: - Array

extension Array where Element == CategoryRealm {

    /// Transforms `CategoryRealm` objects array into `Categories` object or returns nil if `Category` array is empty
    /// - Note: Used mainly for backward compability with databases (some of them returns
    /// empty arrays which may cause impact on bussines logic of user interface)
    /// - Returns: `Categories` object
    func toCategories() -> Categories? {
        guard self.isNotEmpty else { return nil }
        let items = self.map(Category.init)
        return Categories(items: items)
    }
}

//MARK: - Results

extension Results where Element == CategoryRealm {

    /// Transforms `CategoryRealm` objects `Result` into `Categories` object or returns nil if `Category` array is empty
    /// - Note: Used mainly for backward compability with databases (some of them returns
    /// empty arrays which may cause impact on bussines logic of user interface)
    /// - Returns: `Categories` object
    func toCategories() -> Categories? {
        guard self.isEmpty == false else { return nil }
        let items: [Category] = self.map(Category.init)
        return Categories(items: items)
    }
}
