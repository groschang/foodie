//
//  Data+JSON.swift
//  foodieTests
//
//  Created by Konrad Groschang on 13/02/2024.
//

import Foundation

extension Data {

    var prettyString: String? {
        guard
            let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrinted = String(data: data, encoding: .utf8)
        else { return nil }

        return prettyPrinted
    }

}
