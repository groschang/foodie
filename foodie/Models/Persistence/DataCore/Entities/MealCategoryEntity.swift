//
//  MealCategoryEntity.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2023.
//

import CoreData

// MARK: Object Mappable

extension MealCategoryEntity: ObjectMappable {
    
    static func create(_ object: MealCategory, context: NSManagedObjectContext) -> MealCategoryEntity {
        MealCategoryEntity(object, context: context)
    }
    
    convenience init(_ object: MealCategory, context: NSManagedObjectContext) {
        self.init(context: context)
        self.map(object: object)
    }
    
    func map(object: MealCategory) {
        self.id = object.id
        self.name = object.name
        self.imageUrl = object.imageUrl.toString()
    }
}

//MARK: Entity Mappable

extension MealCategory: EntityMappable {
    
    init(entity: MealCategoryEntity) {
        self.id = entity.id
        self.name = entity.name
        self.imageUrl = URL(string: entity.imageUrl)
    }
}

//MARK: Array

extension Array where Element == MealCategoryEntity {
    
    func toMeals() -> Meals? {
        let items = self.map(MealCategory.init)
        return Meals(items: items)
    }
}
