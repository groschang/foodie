//
//  DatabaseLoggerFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 22/01/2024.
//

import Foundation
import Logger

#if MOCKED
    typealias DatabaseLoggerImpl = CoreDataLogger
#elseif SWIFTDATA
    typealias DatabaseLoggerImpl = CoreDataLogger
#elseif NORMAL
    typealias DatabaseLoggerImpl = RealmDatabaseLogger
#endif


extension Logger: DatabaseLogger {

    public static func printDBPath() {
        DatabaseLoggerImpl.printDBPath()
    }

}
