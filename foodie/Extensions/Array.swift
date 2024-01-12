//
//  Array.swift
//  foodie
//
//  Created by Konrad Groschang on 01/09/2023.
//

import Foundation

extension Array {
    @inlinable public var isNotEmpty: Bool {
        isEmpty == false
    }
}


extension Array where Self: Equatable {

    var lastIndex: Int? {
        guard let last = self.last else { return nil }
        return self.lastIndex(of: last)
    }
}
