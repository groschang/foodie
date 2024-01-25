//
//  DecodingErrorTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 31/08/2023.
//

import XCTest
@testable import foodie

final class DecodingErrorTest: XCTestCase {

    private var decoder: JSONDecoder!

    override func setUp() {
        decoder = JSONDecoder()
    }

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
            XCTAssertNotNil(meal, "Expected to parse json file")
        } catch {
            XCTFail("Test case shouldn't throw DecodingError but catch: \(error)")
        }
    }

    func testIncorrectFormatJSONStructure() throws {
        // Given
        let jsonData = """
        Person: {
            "id": 123,
            "name": "String"
        }
        """.data(using: .utf8)!

        // When
        XCTAssertThrowsError(
            try decoder.decode(Person.self, from: jsonData),
            "Test should throw DecodingError: incorrect format"
        ) { error in
            // Then
            DescriptionValidator.validate(error as? DecodingError) {
                "Description:"
                "The data couldn’t be read because it isn’t in the correct format."

                "Context:"
                "description:"
                "The given data was not valid JSON."

                "underlyingError:"
                "The data couldn’t be read because it isn’t in the correct format."
            }
        }
    }

    func testIncorrectFormatMistype() throws {
        // Given
        let jsonData = """
        {
            "id": 123,
            "name": 123
        }
        """.data(using: .utf8)!

        // When
        XCTAssertThrowsError(
            try decoder.decode(Person.self, from: jsonData),
            "Test should throw DecodingError: incorrect format"
        ) { error in
            // Then
            DescriptionValidator.validate(error as? DecodingError) {
                "Description:"
                "The data couldn’t be read because it isn’t in the correct format."

                "Context:"
                "codingPath:"
                "[CodingKeys(stringValue: \"name\", intValue: nil)]"

                "description:"
                "Expected to decode String but found number instead."
            }
        }
    }

    func testMissingData() throws {
        // Given
        let jsonData = """
        {
            "id": 123
        }
        """.data(using: .utf8)!

        // When
        XCTAssertThrowsError(
            try decoder.decode(MealDetail.self, from: jsonData),
            "Test should throw DecodingError: missing data"
        ) { error in
            // Then
            DescriptionValidator.validate(error as? DecodingError) {
                "Description:"
                "The data couldn’t be read because it is missing."

                "Key:"
                "CustomCodingKeys(stringValue: \"idMeal\", intValue: nil)"

                "Context:"
                "description:"
                "No value associated with key CustomCodingKeys(stringValue: \"idMeal\", intValue: nil) (\"idMeal\")."
            }
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
            XCTAssertTrue(description.contains(item),
                          """
                          Description:
                          \(description)
                          should contains:
                          \(item)
                          """)
        }
    }

    static func validate(_ error: DecodingError?, @DescriptionValidator block: () -> [String]) {
        do {
            let error = try XCTUnwrap(error)
            validate(error.verbose, block: block)
        } catch {
            XCTFail("Error is nil")
        }
    }
}
