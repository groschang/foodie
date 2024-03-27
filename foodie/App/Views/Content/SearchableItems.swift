//
//  SearchableItems.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

protocol SearchableItems: Items, Searchable { }

extension SearchableItems {

    func filter(query: String? = nil, mapping: (T) -> String) -> [T] {
        filter(items: items, query: query, mapping: mapping)
    }
}
