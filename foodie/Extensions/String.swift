//
//  String.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

extension String {
    
    func trunc(_ length: Int) -> String {
        let trailingMark = "..."
        let trailingMarkLenght = trailingMark.count
        
        if self.count > length {
            let prefix = self.prefix(length - trailingMarkLenght)
            return prefix + trailingMark
        } else {
            return self
        }
    }
    
    func trunc(to character: Character, ifExists: Bool = false, appendingTruced: Bool = false) -> String {
        guard let firstIndex = self.firstIndex(of: character) else {
            return ifExists ? self : ""
        }
        
        let substring = String(self.prefix(upTo: firstIndex))
        
        if appendingTruced {
            return substring + String(character)
        } else {
            return substring
        }
    }
    
    func removeWhitespaces() -> String {
        self.filter { !$0.isNewline }
    }
}

extension String {
    static let empty = ""
}

extension String {
    @inlinable public var isNotEmpty: Bool {
        isEmpty == false
    }
}

