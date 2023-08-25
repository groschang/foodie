//
//  StringIdentifier.swift
//  foodie
//
//  Created by Konrad Groschang on 27/07/2023.
//

protocol StringIdentifier: Identifiable {
    var stringIdentifier: String { get }
}

extension StringIdentifier {
    var stringIdentifier: String { "\(id)" }
}
