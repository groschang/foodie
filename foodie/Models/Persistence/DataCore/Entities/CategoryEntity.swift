//
//  CategoryEntity.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import CoreData

// MARK: - Object Mappable

extension CategoryEntity: ObjectMappable {
    
    static func create(_ object: Category, context: NSManagedObjectContext) -> CategoryEntity {
        CategoryEntity(object, context: context)
    }
    
    convenience init(_ object: Category, context: NSManagedObjectContext) {
        self.init(context: context)
        self.map(object: object)
    }
    
    func map(object: Category) {
        self.id = object.id
        self.name = object.name
        self.imageURL = object.imageUrl.toString()
        self.desc = object.description
    }
}

//MARK: - Entity Mappable

extension Category: EntityMappable {

    init(entity: CategoryEntity) {
        self.id = entity.id
        self.name = entity.name
        self.imageUrl = URL(string: entity.imageURL)
        self.description = entity.desc
    }
}

//MARK: - Array

extension Array where Element == CategoryEntity {
    
    func toCategories() -> Categories? {
        let items = self.map(Category.init)
        return Categories(items: items)
    }
}

