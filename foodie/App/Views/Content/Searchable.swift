//
//  Searchable.swift
//  foodie
//
//  Created by Konrad Groschang on 26/04/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

@MainActor
protocol Searchable: ObservableObject {
    associatedtype T: Hashable, Identifiable

    var filteredItems: [T] { get }
    var searchQuery: String { get set }

    func filter(items: [T], query: String?, mapping: (T) -> String) -> [T]
}


extension Searchable {

    @MainActor func filter(items: [T], query: String? = nil, mapping: (T) -> String) -> [T] {
        let searchText = query ?? searchQuery

        return searchText.isEmpty
        ? items
        : items.filter { mapping($0).doesContain(searchText) }
    }
}


private extension String {

    /// Return bool value whatever string containts `query`.
    ///
    /// ```swift
    /// "Hello".doesContain("hello") // true
    /// "Hello".doesContain("flower") // false
    /// ```
    ///
    /// > Important: This is bussiness logic related method. The searched
    /// > text should be case insensitive. Use this method to validate
    /// > if search query containts a given text.
    ///
    /// - Parameters:
    ///     - query: The query to be validated.
    ///
    /// - Returns: A bool value whatever `Self` string contains `query`.
    func doesContain(_ query: String) -> Bool {
        self.localizedCaseInsensitiveContains(query)
    }
}
