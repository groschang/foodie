//
//  Category.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//

import Foundation

struct Category: IdentifiableObject {

    let id: String
    let name: String
    let imageUrl: URL?
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case imageUrl = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}

extension Category: StringIdentifier { }

extension Category: Mockable {
    static let mock: Category = loadMock(from: "category")
}
