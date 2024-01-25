//
//  Mockable.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//

import Foundation


protocol Mockable {
    static var bundle: Bundle { get }
    static func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T
}

extension Mockable {
    
    static var bundle: Bundle {
        Bundle.main
    }

    static func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }

        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(type, from: data)

            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
    }
}

extension Mockable where Self: Decodable {

    static func loadMock(from filename: String) -> Self {
        loadJSON(filename: filename, type: Self.self)
    }
}
