//
//  MealDetailEntity+CoreDataProperties.swift
//  foodie
//
//  Created by Konrad Groschang on 01/02/2023.
//
//

import Foundation
import CoreData


extension MealDetailEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealDetailEntity> {
        return NSFetchRequest<MealDetailEntity>(entityName: "MealDetailEntity")
    }

    @NSManaged public var area: String?
    @NSManaged public var category: String?
    @NSManaged public var id: String
    @NSManaged public var imageURL: String?
    @NSManaged public var name: String
    @NSManaged public var recipe: String?
    @NSManaged public var source: String?
    @NSManaged public var youtubeURL: String?
    @NSManaged public var ingredients: NSSet?

}

// MARK: Generated accessors for ingredients
extension MealDetailEntity {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: IngredientEntity)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: IngredientEntity)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

extension MealDetailEntity : Identifiable {

}
