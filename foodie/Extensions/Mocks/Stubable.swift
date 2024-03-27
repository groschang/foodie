//
//  Stubable.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation


protocol Stubable {
    static var bundle: Bundle { get }
    static func loadJSON(filename: String) -> String?
    static func loadJSON() -> String?
}

extension Stubable {
    
    static var bundle: Bundle {
        Bundle.main
    }

    static func loadJSON(filename: String) -> String? {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to find JSON file")
        }

        do {
            let data = try Data(contentsOf: path)
            return data.prettyString
        } catch {
            fatalError("Failed to load JSON")
        }
    }

    static func loadJSON() -> String? {
        loadJSON(filename: String(describing: self).lowercased())
    }
}

extension Stubable where Self: Decodable {

    static func loadStub(from filename: String) -> Self {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }

        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(self, from: data)
            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
    }
}
