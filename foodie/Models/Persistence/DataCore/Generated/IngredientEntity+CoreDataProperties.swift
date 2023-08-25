//
//  IngredientEntity+CoreDataProperties.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2023.
//
//

import Foundation
import CoreData


extension IngredientEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngredientEntity> {
        return NSFetchRequest<IngredientEntity>(entityName: "IngredientEntity")
    }

    @NSManaged public var name: String
    @NSManaged public var measure: String
    @NSManaged public var mealDetail: MealDetailEntity?

}

extension IngredientEntity : Identifiable {

}
