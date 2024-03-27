//
//  CaseIterable.swift
//  foodie
//
//  Created by Konrad Groschang on 05/02/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

extension CaseIterable {
    
    static func array(from item: Self, to item2: Self) -> [Self] where Self: Equatable {
        let allCases = Self.allCases
        guard let start = allCases.firstIndex(of: item),
              let end = allCases.firstIndex(of: item2) else {
            return []
        }
        return Array(allCases[start...end])
    }
}

extension CaseIterable where Self: Equatable {
    
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
}
