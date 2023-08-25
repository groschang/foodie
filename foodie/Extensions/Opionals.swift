//
//  Opionals.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2023.
//

import Foundation

extension Optional {
    
    var isNil: Bool {
        self == nil
    }
}

extension Optional {
    
    func toString() -> String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case .none:
            return ""
        }
    }
}
