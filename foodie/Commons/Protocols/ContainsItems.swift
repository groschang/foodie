//
//  ContainsItems.swift
//  foodie
//
//  Created by Konrad Groschang on 27/07/2023.
//

protocol ContainsItems: ContainsElements {
    associatedtype T
    var items: [T] { get }
}

extension ContainsItems {
    var isEmpty: Bool { items.isEmpty }
}
