//
//  SearchableItems.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//

import Foundation

protocol SearchableItems: Items, Searchable { }

extension SearchableItems {

    func filter(query: String? = nil, mapping: (T) -> String) -> [T] {
        filter(items: items, query: query, mapping: mapping)
    }
}
