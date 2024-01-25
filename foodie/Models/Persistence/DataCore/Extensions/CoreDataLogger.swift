//
//  CoreDataLogger.swift
//  foodie
//
//  Created by Konrad Groschang on 22/01/2024.
//

import Foundation

public struct CoreDataLogger: DatabaseLogger {

    private static let fileManager = FileManager.default

    private static var databasePathString: String? {
        guard let path = fileManager.urls(for: .applicationSupportDirectory,
                                          in: .userDomainMask).first
        else {
            return nil
        }

        guard let files = try? fileManager.contentsOfDirectory(
            at: path,
            includingPropertiesForKeys: nil
        ) else {
            return nil
        }

        let dbFiles = files.map { $0.absoluteString }.filter { $0.hasSuffix("sqlite") }

        return dbFiles.first
    }

    public static func printDBPath() {
        Logger.log(databasePathString ?? "Path error", onLevel: .info)
    }
}
