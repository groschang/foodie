//
//  MealCategoryEntity+CoreDataProperties.swift
//  foodie
//
//  Created by Konrad Groschang on 03/08/2023.
//
//

import Foundation
import CoreData


extension MealCategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealCategoryEntity> {
        return NSFetchRequest<MealCategoryEntity>(entityName: "MealCategoryEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var imageUrl: String
    @NSManaged public var name: String
    @NSManaged public var category: CategoryEntity?

}

extension MealCategoryEntity : Identifiable {

}
