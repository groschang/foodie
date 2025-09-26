//
//  Categories.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

struct Categories: Codable, Hashable, Equatable {
    
    var items: [Category]
    
    enum CodingKeys: String, CodingKey {
        case items = "categories"
    }
}


extension Categories: Identifiable {

    var id: Int { hashValue }
}


extension Categories: ContainsItems { }


extension Categories: StaticIdentifier {
    static let Identifier: String = "categories"
}

// MARK: - Sutbs

extension Categories: Stubable {
    static let stub: Categories = loadStub(from: "categories")
}

//MARK: - Iterator

struct CategoriesIterator: IteratorProtocol {

    private var current = 0
    private let items: [Category]

    init(items: [Category]) {
        self.items = items
    }

    mutating func next() -> Category? {
        defer { current += 1 }
        return items.count > current ? items[current] : nil
    }

}


extension Categories: Sequence {

    func makeIterator() -> CategoriesIterator {
        CategoriesIterator(items: items)
    }
}
