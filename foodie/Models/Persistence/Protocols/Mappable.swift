//
//  Mappable.swift
//  foodie
//
//  Created by Konrad Groschang on 01/02/2023.
//

//import SwiftData
import CoreData

protocol ObjectMappable {
    associatedtype Object = EntityMappable
    associatedtype SelfType = Self
    associatedtype DatastoreContext

    static func create(_ object: Object, context: DatastoreContext) -> SelfType
}

//protocol CoreDataMappable: ObjectMappable where DatastoreContext == NSManagedObjectContext { }
//
//protocol SwiftDataMappable: ObjectMappable where DatastoreContext == ModelContext { }



protocol EntityMappable {
    associatedtype Entity

    init(entity: Entity)
}

//protocol CoreDataEntityMappable: EntityMappable where Entity == NSManagedObject { }
//
//protocol SwiftDataEntityMappable: EntityMappable where Entity == AnyObject { }

