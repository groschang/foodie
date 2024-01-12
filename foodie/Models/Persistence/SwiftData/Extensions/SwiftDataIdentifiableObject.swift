//
//  SwiftDataIdentifiableObject.swift
//  foodie
//
//  Created by Konrad Groschang on 09/01/2024.
//

import Foundation
import SwiftData

extension PersistentModel where Self: Identifier {

    static func get(id: ObjectID, in modelContext: ModelContext) -> Self? {

        var descriptor = FetchDescriptor<Self>()
        descriptor.predicate = #Predicate { item in
            item.identifier == id
        }

        return getElements(descriptor: descriptor, in: modelContext)

    }

    static func get(object: any IdentifiableObject, in modelContext: ModelContext) -> Self? {
        get(id: object.identifier, in: modelContext)
    }

    static func get(objectId: ObjectId, in modelContext: ModelContext) -> Self? {
        get(id: objectId.identifier, in: modelContext)
    }
}

extension PersistentModel where Self: Identifier {

    static func get<I: Identifier>(object: I, in modelContext: ModelContext) -> Self? {

        /// Workaround for #Predicate macro that doesn't accept protocol
        let id: String = object.identifier

        var descriptor = FetchDescriptor<Self>()
        descriptor.predicate = #Predicate<Self> { item in
            item.identifier < id
        }

        return getElements(descriptor: descriptor, in: modelContext)

    }
}


extension PersistentModel {

    static func get(in modelContext: ModelContext) -> [Self]? {

        let descriptor = FetchDescriptor<Self>()

        return getElement(descriptor: descriptor, in: modelContext)
    }

    static func getElement(descriptor: FetchDescriptor<Self>, in modelContext: ModelContext) -> [Self]? {
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            return nil
        }
    }

    static func getElements(descriptor: FetchDescriptor<Self>, in modelContext: ModelContext) -> Self? {

        do {

            let fetchResult: [Self]? = try modelContext.fetch(descriptor)

            guard let fetchResult else { return nil }
            assert(fetchResult.count <= 1, "Fetching result should contain only zero or one element")
            guard let object = fetchResult.first else { return nil }

            return object

        } catch {
            Log.error("Database fetching error: \(error)")
            return nil
        }

    }

}
