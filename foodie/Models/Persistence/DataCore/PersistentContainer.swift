//
//  PersistentContainer.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2023.
//

import CoreData

enum StoreType {
    case SQLite
    case binary
    case inMemory
}

extension StoreType: CustomStringConvertible {
    var description: String {
        switch self {
        case .SQLite: return NSSQLiteStoreType
        case .binary: return NSBinaryStoreType
        case .inMemory: return NSInMemoryStoreType
        }
    }
}

final class PersistentContainer: NSPersistentContainer {

    static let DataModelName = "Foodie"

    public init(name: String, managedObjectModel: NSManagedObjectModel, type: StoreType = .SQLite) {
        super.init(name: name, managedObjectModel: managedObjectModel)
        configureDefaults(type)
    }

    public convenience init(name: String = DataModelName, bundle: Bundle = .main, type: StoreType = .SQLite) {

        guard let modelURL = bundle.url(forResource: name, withExtension: "momd") else {
            fatalError("Failed to find data model")
        }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to create NSManagedObjectModel")
        }

        self.init(name: name, managedObjectModel: model, type: type)
    }


    private func configureDefaults(_ type: StoreType) {

        let description = NSPersistentStoreDescription()
        description.type = type.description

        if description.type == StoreType.inMemory.description {
            description.url = URL(fileURLWithPath: "/dev/null/")
        }

        if description.type == StoreType.SQLite.description || description.type == StoreType.binary.description  {
            description.url = FileManager.default
                .urls(for: .documentDirectory,
                      in: .userDomainMask)
                .first?
                .appendingPathComponent("database")
        }

        persistentStoreDescriptions = [description]
    }


    func saveContext(_ context: NSManagedObjectContext) {
        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch let error as NSError {
            Logger.log("Core data context: \(error), \(error.userInfo)", onLevel: .error)
        }
    }
}
