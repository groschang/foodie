//
//  DatabaseLoggerFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 22/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import Logger

#if REALM
    typealias DatabaseLoggerImpl = RealmDatabaseLogger
#else
    typealias DatabaseLoggerImpl = RealmDatabaseLogger
#endif


extension Logger: @retroactive DatabaseLogger {

    public static func printDBPath() {
        DatabaseLoggerImpl.printDBPath()
    }
}
