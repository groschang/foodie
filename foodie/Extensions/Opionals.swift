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

    var isNotNil: Bool {
        isNil == false
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


extension String.StringInterpolation {
    mutating func appendInterpolation<T>(unwrap optional: T?) {
        appendLiteral(optional.toString())
    }
}
