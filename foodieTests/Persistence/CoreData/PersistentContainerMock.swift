//
//  PersistentContainerMock.swift
//  foodieTests
//
//  Created by Konrad Groschang on 03/08/2023.
//

import CoreData

class PersistentContainerMock: NSPersistentContainer {

    static let DataModelName = "Foodie"

    enum StoreType: CustomStringConvertible {
        case SQLite
        case binary
        case inMemory

        var description: String {
            switch self {
            case .SQLite: return NSSQLiteStoreType
            case .binary: return NSBinaryStoreType
            case .inMemory: return NSInMemoryStoreType
            }
        }
    }

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
            description.url = URL(fileURLWithPath: "/dev/null/\(UUID())/")
        }

//        if description.type == StoreType.SQLite.description
//            || description.type == StoreType.binary.description  {
//            // for persistence on local storage we need to set url
//            description.url = FileManager.default.urls(for: .documentDirectory,
//                                                       in: .userDomainMask)
//            .first?
//            .appendingPathComponent("database")
//        }

        persistentStoreDescriptions = [description]
    }

    func saveContext(_ context: NSManagedObjectContext) {
        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch let error as NSError {
           print("Core data context: \(error), \(error.userInfo)")
        }
    }
}
