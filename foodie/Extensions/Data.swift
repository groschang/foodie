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

    var prettyString: String? {
        guard
            let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrinted = String(data: data, encoding: .utf8)
        else { return nil }

        return prettyPrinted
    }

}
