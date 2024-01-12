//
//  IngredientEntity.swift
//  foodie
//
//  Created by Konrad Groschang on 06/02/2023.
//

import CoreData

// MARK: Object Mappable

extension IngredientEntity {
    
    convenience init(_ ingredient: Ingredient, context: NSManagedObjectContext) {
        self.init(context: context)
        self.map(ingredient: ingredient)
    }
    
    func map(ingredient: Ingredient) {
        self.name = ingredient.name
        self.measure = ingredient.measure
    }
}

//MARK: Entity Mappable

extension Ingredient {
    
    init(entity: IngredientEntity) {
        self.name = entity.name
        self.measure = entity.measure
    }
}

extension Array where Element == Ingredient {
    func toIngredientEntities(context: NSManagedObjectContext) -> NSSet? {
        map { IngredientEntity($0, context: context) }.toNSSet()
    }
}

//MARK: Array

extension Array where Element == IngredientEntity {
    
    func toIngredients() -> [Ingredient] {
        map(Ingredient.init)
    }
}
