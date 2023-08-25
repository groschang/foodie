//
//  LoadingStateTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 02/07/2023.
//

import XCTest
@testable import foodie

final class LoadingStateTest: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func testRawRepresentable() {
        // Arrange
        let value = "idle"

        // Act
        let state = LoadingState(rawValue: value)

        // Assert
        XCTAssertEqual(state, .idle)
    }

}
