//
//  Items.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

protocol Items {
    associatedtype T: Hashable, Identifiable

    var items: [T] { get }
}
