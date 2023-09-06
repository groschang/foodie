//
//  CategoryViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 17/05/2023.
//

import Foundation

struct CategoryViewModel {

    let name: String
    let description: String
    let imageURL: URL?

    init(category: Category) {
        self.name = category.name
        self.description = Self.description(for: category)
        self.imageURL = category.imageUrl
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
    ///     - category: The category that description should be returned.
    ///
    /// - Returns: A description string  for `category`.
    private static func description(for category: Category) -> String {
        category.description
            .removeWhitespaces()
            .trunc(to: Truncation.terminator, ifExists: true, appendingTruced: true)
            .trunc(Truncation.length)
    }
}



extension CategoryViewModel {
    static let mock = CategoryViewModel(category: .mock)
}
