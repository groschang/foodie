//
//  Items.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//

import Foundation

protocol Items {
    associatedtype T: Hashable, Identifiable

    var items: [T] { get }
}
