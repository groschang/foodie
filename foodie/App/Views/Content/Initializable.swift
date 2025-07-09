//
//  Initializable.swift
//  foodie
//
//  Created by Konrad Groschang on 18/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

@MainActor
protocol Initializable {
    var initialized: Bool { get }
    func initialize() async
}
