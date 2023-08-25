//
//  Data.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//

import Foundation

extension Data {
    func toObject<T:Decodable>(_ type: T.Type) -> T? {
        try? JSONDecoder().decode(type, from: self)
    }
}
