//
//  Categories.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
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

extension Categories: StaticIdentifier { //TODO: better idea?
    static let Identifier: String = "categories"
}

extension Categories: Mockable {
    static let mock: Categories = loadMock(from: "categories")
}
