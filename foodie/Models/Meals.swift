//
//  Meals.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

struct Meals: Codable, Hashable, Equatable {
    
    var items: [MealCategory]
    
    enum CodingKeys: String, CodingKey {
        case items = "meals"
    }

}


extension Meals: Identifiable {
    var id: Int { hashValue }
}


extension Meals: ContainsItems { }


extension Meals: StringIdentifier { }


// MARK: - Sutbs

extension Meals: Stubable {
    static let stub: Meals = loadStub(from: "meals")
}


// MARK: - Iterator

struct MealsIterator: IteratorProtocol {

    private var current = 0
    private let items: [MealCategory]

    init(items: [MealCategory]) {
        self.items = items
    }

    mutating func next() -> MealCategory? {
        defer { current += 1 }
        return items.count > current ? items[current] : nil
    }

}


extension Meals: Sequence {

    func makeIterator() -> some IteratorProtocol {
        MealsIterator(items: items)
    }
}
