//
//  RealmLogger.swift
//  
//
//  Created by Konrad Groschang on 22/01/2024.
//

import RealmSwift

public struct RealmDatabaseLogger: DatabaseLogger {

    public static func printDBPath() {
        Logger.log( "Realm filepath:" )
        Logger.log( Realm.Configuration.defaultConfiguration.fileURL! )
    }
}
