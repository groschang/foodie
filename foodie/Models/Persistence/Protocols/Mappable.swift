//
//  Mappable.swift
//  foodie
//
//  Created by Konrad Groschang on 01/02/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import CoreData

protocol ObjectMappable {
    associatedtype Object = EntityMappable
    associatedtype SelfType = Self
    associatedtype DatastoreContext

    static func create(_ object: Object, context: DatastoreContext) -> SelfType
}

protocol EntityMappable {
    associatedtype Entity

    init(entity: Entity)
}
