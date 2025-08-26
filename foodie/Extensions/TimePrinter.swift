//
//  TimePrinter.swift
//  foodie
//
//  Created by Konrad Groschang on 13/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

public extension DateFormatter {

    static let medium  = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()

    static let long  = {
        let formatter = DateFormatter()
        formatter.timeStyle = .long
        return formatter
    }()
}

public extension Date {
    
    var title: String {
        let formatter = DateFormatter.medium
        return formatter.string(from: self)
    }

    var long: String {
        let formatter = DateFormatter.long
        return formatter.string(from: self)
    }
}

public extension Double {

    var title: String {
        let formatter = DateFormatter.medium
        let interval = TimeInterval(self)
        let date = Date(timeIntervalSince1970: interval)
        return formatter.string(from: date)
    }
}


