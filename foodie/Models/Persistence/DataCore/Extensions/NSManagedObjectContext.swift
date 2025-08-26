//
//  NSManagedObjectContext.swift
//  foodie
//
//  Created by Konrad Groschang on 28/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

@preconcurrency import CoreData

extension NSManagedObjectContext {

    func fetch<T>(request: NSFetchRequest<T>) async -> [T]? where T: NSManagedObject {
        await perform {
            do {
                return try request.execute()
            } catch {
                Logger.log("Core data fetch problem: \(error)", onLevel: .error)
                return nil
            }
        }
    }
}
