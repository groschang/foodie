//
//  BackgroundRealm.swift
//  foodie
//
//  Created by Konrad Groschang on 22/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

@preconcurrency import RealmSwift
import Foundation

@globalActor actor BackgroundActor: GlobalActor {
    static let shared = BackgroundActor()
}

extension Realm {

    @BackgroundActor
    func saveAsync<T: Object>(_ object: T) async {
        do {
            let realm = try await Realm.backgroundInstance(from: self)

            try await realm.asyncWrite {
                realm.add(object, update: .modified)
            }
        } catch {
            Log.error("Unable to store data: \(error)")
        }
    }

    @BackgroundActor
    func saveAsync<T: Object>(_ objects: [T]) async {
        do {
            let realm = try await Realm.backgroundInstance(from: self)

            try await realm.asyncWrite {
                for item in objects {
                    realm.add(item, update: .modified)
                }
            }
        } catch {
            Log.error("Unable to store data: \(error)")
        }
    }

}

extension Realm {

    @BackgroundActor
    static func backgroundInstance(from otherRealm: Realm) async throws -> Realm {
        var configuration = Realm.Configuration()
        // Accessing configuration is safe because it's a value type (struct)
        configuration.fileURL = otherRealm.configuration.fileURL

        // This opens the Realm specifically isolated to the BackgroundActor
        return try await Realm(configuration: configuration, actor: BackgroundActor.shared)
    }
}
