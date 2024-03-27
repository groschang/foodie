//
//  LoadingStateTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 02/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import XCTest
@testable import foodie

final class LoadingStateTest: XCTestCase {

    func testRawRepresentable() {
        // Arrange
        let value = "idle"

        // Act
        let state = LoadingState(rawValue: value)

        // Assert
        XCTAssertEqual(state, .idle)
    }

}
