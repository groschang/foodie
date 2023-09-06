//
//  DecodingErrorTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 31/08/2023.
//

import XCTest
@testable import foodie

//TODO: make separate independent structure and test based on that structure not realted with DecodingErrorDescription test

final class DecodingErrorTest: XCTestCase {

    private var decoder: JSONDecoder!

    override func setUp() {
        decoder = JSONDecoder()
    }

    func testCorrectFormat() throws {
        // Given
        let json = """
        {
            "idMeal": "52838",
            "strMeal": "Venetian Duck Ragu"
        }
        """
        let data = json.data(using: .utf8)!

        // When
        do {
            let meal = try decoder.decode(MealDetail.self, from: data)

            // Then
            XCTAssertNotNil(meal, "Expected to parse json file")
        } catch {
            XCTFail("Test case should not throw DecodingError")
        }
    }

    func testIncorrectFormatJSONStructure() throws {
        // Given
        let json = """
        Meal: {
            "idMeal": "52838",
            "strMeal": "Venetian Duck Ragu"
        }
        """
        let data = Data(json.utf8)

        // When
        do {
            _ = try decoder.decode(MealDetail.self, from: data)

            XCTFail("Test case should throw DecodingError")
        } catch let error as DecodingError {
            DescriptionValidator.validate(error.verbose) {
                "Description:"
                "The data couldn’t be read because it isn’t in the correct format."

                "Context:"
                "description:"
                "The given data was not valid JSON."

                "underlyingError:"
                "The data couldn’t be read because it isn’t in the correct format."
            }
        } catch {
            XCTFail("Test case should throw DecodingError")
        }
    }

    func testIncorrectFormatMistype() throws {
        // Given
        let json = """
        {
            "idMeal": "52838",
            "strMeal": 52838
        }
        """
        let data = Data(json.utf8)

        // When
        do {
            _ = try decoder.decode(MealDetail.self, from: data)

            XCTFail("Test case should throw DecodingError")
        } catch let error as DecodingError {
            DescriptionValidator.validate(error.verbose) {
                "Description:"
                "The data couldn’t be read because it isn’t in the correct format."

                "Context:"
                "codingPath:"
                "[CustomCodingKeys(stringValue: \"strMeal\", intValue: nil)]"

                "description:"
                "Expected to decode String but found a number instead."
            }
        } catch {
            XCTFail("Test case should throw DecodingError")
        }
    }

    func testMissingData() throws {
        // Given
        let json = """
        {
            "idMeal": "52838"
        }
        """
        let data = Data(json.utf8)

        // When
        do {
            _ = try decoder.decode(MealDetail.self, from: data)

            XCTFail("Test case should throw DecodingError")
        } catch let error as DecodingError {
            print(error.verbose)
            DescriptionValidator.validate(error.verbose) {
                "Description:"
                "The data couldn’t be read because it is missing."

                "Key:"
                "CustomCodingKeys(stringValue: \"strMeal\", intValue: nil)"

                "Context:"
                "description:"
                "No value associated with key CustomCodingKeys(stringValue: \"strMeal\", intValue: nil) (\"strMeal\")."
            }
        } catch {
            XCTFail("Test case should throw DecodingError")
        }
    }
}

@resultBuilder
fileprivate struct DescriptionValidator {

    static func buildBlock(_ parts: String...) -> [String] {
        parts
    }

    static func validate(_ description: String, @DescriptionValidator block: () -> [String]) {
        block().forEach { item in
            XCTAssertTrue(description.contains(item))
        }
    }
}
