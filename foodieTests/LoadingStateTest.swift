//
//  LoadingStateTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 02/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Testing
@testable import foodie

@Suite struct LoadingStateTest {

    @Test("Test LoadingState RawRepresentable conformance")
    func testRawRepresentable() {
        // Arrange
        let value = "idle"

        // Act
        let state = LoadingState(rawValue: value)

        // Assert
        #expect(state == .idle, "Expected state to be .idle")
    }

}