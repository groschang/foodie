//
//  CaseIterable.swift
//  foodie
//
//  Created by Konrad Groschang on 05/02/2023.
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
