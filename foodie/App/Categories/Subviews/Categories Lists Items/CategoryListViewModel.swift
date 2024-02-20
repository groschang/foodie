//
//  CategoryListItemModel.swift
//  foodie
//
//  Created by Konrad Groschang on 17/05/2023.
//

import Foundation

struct CategoryListItemModel {

    let name: String
    let description: String
    let imageURL: URL?

    init(category: Category) {
        self.name = category.name
        self.description = CategoryDescription(category).description
        self.imageURL = category.imageUrl
    }

}


extension CategoryListItemModel {
    static let mock = CategoryListItemModel(category: .stub)
}


private struct CategoryDescription: CustomStringConvertible {

    let text: String

    init(_ text: String) {
        self.text = text
    }

    init(_ category: Category) {
        self.init(category.description)
    }

    /// Conforms CustomStringConvertible
    var description: String {
        Self.description(for: text)
    }

    /// Truncation constants
    private struct Truncation {

        /// Truncation lenght
        static let length: Int = 120

        /// Truncation ending character
        static let terminator: Character = "."
    }

    /// Returns description for meal `category`.
    ///
    /// ```swift
    /// Self.description(for: category) // "category name"
    /// ```
    ///
    /// > Important: This is bussiness logic related method. The description
    /// > text should be trunced to nearest end of sentence terminator
    /// >  or to limited 120 letters totally.
    ///
    /// - Parameters:
    ///     - text: The string value which a description should be returned.
    ///
    /// - Returns: A description string  for `category`.
    private static func description(for text: String) -> String {
        text
            .removeWhitespaces()
            .trunc(to: Truncation.terminator, ifExists: true, appendingTruced: true)
            .trunc(Truncation.length)
    }
}
