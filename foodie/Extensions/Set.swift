//
//  Set.swift
//  foodie
//
//  Created by Konrad Groschang on 18/02/2023.
//

import Foundation

extension Set {
    
    func toArray() -> [Element] {
        Array(self)
    }
}

extension Array {

    func toNSSet() -> NSSet? {
        .init(array: self)
    }
}
