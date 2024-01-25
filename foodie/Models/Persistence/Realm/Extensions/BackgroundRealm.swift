//
//  BackgroundRealm.swift
//  foodie
//
//  Created by Konrad Groschang on 22/01/2024.
//

import RealmSwift
import Foundation

extension Realm {

    func saveAsync<T: Object>(_ object: T) async {
        do {

            let realm = try await Realm(copyFileURLFrom: self)

            try await realm.asyncWrite {
                realm.add(object, update: .modified)
            }

        } catch {
            Log.error("Unable to store data: \(error)")
        }
    }


    func saveAsync<T: Object>(_ objects: [T]) async {
        do {

            let realm: Realm = try await Realm(copyFileURLFrom: self)

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

    init(copyFileURLFrom realm: Realm) async throws {

        var configuration = Realm.Configuration()
        configuration.fileURL = realm.configuration.fileURL

        self = try await Realm(configuration: configuration)
    }

}
