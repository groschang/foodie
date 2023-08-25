//
//  Mappable.swift
//  foodie
//
//  Created by Konrad Groschang on 01/02/2023.
//

import CoreData

protocol ObjectMappable {
    associatedtype Object = EntityMappable
    associatedtype SelfType = Self
    
    static func create(_ object: Object, context: NSManagedObjectContext) -> SelfType
}

protocol EntityMappable {
    associatedtype Entity = NSManagedObject
    
    init(entity: Entity)
}
