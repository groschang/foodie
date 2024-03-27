//
//  StringIdentifier.swift
//  foodie
//
//  Created by Konrad Groschang on 27/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

protocol StringIdentifier: Identifiable {
    var stringIdentifier: String { get }
}

extension StringIdentifier {
    var stringIdentifier: String { "\(id)" }
}
