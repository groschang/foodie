//
//  DecodingErrorTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 31/08/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Testing
import Foundation
@testable import foodie

@Suite struct DecodingErrorTest {

    private var decoder: JSONDecoder!

    init() {
        decoder = JSONDecoder()
    }

    @Test("Test decoding with correct JSON format")
    func testCorrectFormat() throws {
        // Given
        let jsonData = """
        {
            "id": 123,
            "name": "String"
        }
        """.data(using: .utf8)!

        // When
        do {
            let meal = try decoder.decode(Person.self, from: jsonData)
            // Then
            #expect(meal.id == 123, "Expected person ID to be 123")
            #expect(meal.name == "String", "Expected person name to be 'String'")
        } catch {
            Issue.record("Test case shouldn't throw DecodingError but catch: \(error)")
        }
    }

    @Test("Test decoding with incorrect JSON structure")
    func testIncorrectFormatJSONStructure() throws {
        // Given
        let jsonData = """
        Person: {
            "id": 123,
            "name": "String"
        }
        """.data(using: .utf8)!

        // When
        #expect(throws: DecodingError.self) {
            try decoder.decode(Person.self, from: jsonData)
        }
        
        do {
            let _ = try decoder.decode(Person.self, from: jsonData)
            Issue.record("Test should throw DecodingError: incorrect format")
        } catch let error as DecodingError {
            // Then
            DescriptionValidator.validate(error) {
                "Description:"
                "The data couldn’t be read because it isn’t in the correct format."

                "Context:"
                "description:"
                "The given data was not valid JSON."

                "underlyingError:"
                "The data couldn’t be read because it isn’t in the correct format."
            }
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }

    @Test("Test decoding with type mismatch")
    func testIncorrectFormatMistype() throws {
        // Given
        let jsonData = """
        {
            "id": 123,
            "name": 123
        }
        """.data(using: .utf8)!

        // When
        #expect(throws: DecodingError.self) {
            try decoder.decode(Person.self, from: jsonData)
        }
        
        do {
            let _ = try decoder.decode(Person.self, from: jsonData)
            Issue.record("Test should throw DecodingError: incorrect format")
        } catch let error as DecodingError {
            // Then
            DescriptionValidator.validate(error) {
                "Description:"
                "The data couldn’t be read because it isn’t in the correct format."

                "Context:"
                "codingPath:"
                "[CodingKeys(stringValue: \"name\", intValue: nil)]"

                "description:"
                "Expected to decode String but found number instead."
            }
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }

    @Test("Test decoding with missing data")
    func testMissingData() throws {
        // Given
        let jsonData = """
        {
            "id": 123
        }
        """.data(using: .utf8)!

        // When
        #expect(throws: DecodingError.self) {
            try decoder.decode(MealDetail.self, from: jsonData)
        }
        
        do {
            let _ = try decoder.decode(MealDetail.self, from: jsonData)
            Issue.record("Test should throw DecodingError: missing data")
        } catch let error as DecodingError {
            // Then
            DescriptionValidator.validate(error) {
                "Description:"
                "The data couldn’t be read because it is missing."

                "Key:"
                "CustomCodingKeys(stringValue: \"idMeal\", intValue: nil)"

                "Context:"
                "description:"
                "No value associated with key CustomCodingKeys(stringValue: \"idMeal\", intValue: nil) (\"idMeal\")."
            }
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
}

fileprivate struct Person: Decodable {
    let id: Int
    let name: String
}

@resultBuilder
fileprivate struct DescriptionValidator {

    static func buildBlock(_ parts: String...) -> [String] {
        parts
    }

    static func validate(_ description: String, @DescriptionValidator block: () -> [String]) {
        block().forEach { item in
            #expect(description.contains(item),
                      """
                      Description:
                      \(description)
                      should contains:
                      \(item)
                      """)
        }
    }

    static func validate(_ error: DecodingError, @DescriptionValidator block: () -> [String]) {
        validate(error.verbose, block: block)
    }
}
