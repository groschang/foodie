//
//  MealDetailEntity.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import CoreData

// MARK: Object Mappable

extension MealDetailEntity: ObjectMappable {
    
    static func create(_ object: Meal, context: NSManagedObjectContext) -> MealDetailEntity {
        MealDetailEntity(object, context: context)
    }
    
    convenience init(_ object: Meal, context: NSManagedObjectContext) {
        self.init(context: context)
        self.map(meal: object, context: context)
    }
    
    func map(meal: Meal, context: NSManagedObjectContext) {
        self.id = meal.id
        self.name = meal.name
        self.category = meal.category
        self.area = meal.area
        self.recipe = meal.recipe
        self.imageURL = meal.imageURL.toString()
        self.youtubeURL =  meal.youtubeURL.toString()
        self.source = meal.source
        self.ingredients = meal.ingredients?.toIngredientEntities(meal: self, context: context)
    }
}

//MARK: - Entity Mappable

extension Meal: EntityMappable {
    
    init(entity: MealDetailEntity) {
        self.id = entity.id
        self.name = entity.name
        self.category = entity.category
        self.area = entity.area
        self.recipe = entity.recipe
        self.imageURL = URL(string: entity.imageURL)
        self.youtubeURL = URL(string: entity.youtubeURL)
        self.source = entity.source
        self.ingredients =  ingredients(entity.ingredientsSet)
    }

    private func ingredients(_ ingredients: Set<IngredientEntity>?) -> [Ingredient]? {
        guard let ingredientsArray = ingredients?.toArray() else { return nil }
        guard ingredientsArray.count > 0 else { return nil }

        return ingredientsArray
            .map(Ingredient.init)
            .sorted()
    }
}


//MARK: - Set

extension MealDetailEntity {
    
    var ingredientsSet: Set<IngredientEntity>? {
        guard let ingredients = self.ingredients else { return nil }
        guard ingredients.count > 0 else { return nil }

        return ingredients as? Set<IngredientEntity>
    }
}

//MARK: - Array

extension Array where Element == MealDetailEntity {
    
    func toMeals() -> [Meal?] {
        self.map(Meal.init)
    }

    func toMeal() -> Meal? {
        guard let item = self.first else { return nil }
        
        return Meal(entity: item) //TODO: check me
    }
}
