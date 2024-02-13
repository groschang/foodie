//
//  CoordinateSpace.swift
//  foodie
//
//  Created by Konrad Groschang on 08/04/2023.
//

import Foundation

enum CoordinateSpace: String {
    case main
    case context
    case image
}

extension CoordinateSpace: CustomStringConvertible {

    var description: String {
        rawValue
    }
}
