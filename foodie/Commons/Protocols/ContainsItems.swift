//
//  ContainsItems.swift
//  foodie
//
//  Created by Konrad Groschang on 27/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

protocol ContainsItems: ContainsElements {
    associatedtype T
    var items: [T] { get }
}

extension ContainsItems {
    var isEmpty: Bool { items.isEmpty }
}
