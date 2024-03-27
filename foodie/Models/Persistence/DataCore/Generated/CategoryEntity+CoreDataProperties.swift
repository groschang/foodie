//
//  CategoryEntity+CoreDataProperties.swift
//  foodie
//
//  Created by Konrad Groschang on 01/02/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var desc: String
    @NSManaged public var id: String
    @NSManaged public var imageURL: String
    @NSManaged public var name: String
    @NSManaged public var mealCategories: NSSet?

}

// MARK: Generated accessors for mealCategories
extension CategoryEntity {

    @objc(addMealCategoriesObject:)
    @NSManaged public func addToMealCategories(_ value: MealCategoryEntity)

    @objc(removeMealCategoriesObject:)
    @NSManaged public func removeFromMealCategories(_ value: MealCategoryEntity)

    @objc(addMealCategories:)
    @NSManaged public func addToMealCategories(_ values: NSSet)

    @objc(removeMealCategories:)
    @NSManaged public func removeFromMealCategories(_ values: NSSet)

}

extension CategoryEntity : Identifiable {

}
