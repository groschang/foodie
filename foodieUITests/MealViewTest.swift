//
//  MealViewTest.swift
//  foodie
//
//  Created by Konrad Groschang on 15/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import XCTest
import Testing

@Suite struct UITests {

    @MainActor @Test
    func foodieOfTheDayExistence() {
        let app = XCUIApplication(bundleIdentifier: "com.conrad.foodie")
        app.launch()

        // Given
        /// Select mocked meal (all are equal)
        let label = app.staticTexts["Foodie of the day"]

        // When
        guard label.waitForExistence(timeout: 5) else {
            #expect(Bool(false), "Label should exist")
            return
        }
        label.tap()

        // Then
        let titleLabel = app.staticTexts["Coddled pork with cider"]
        guard titleLabel.waitForExistence(timeout: 5) else {
            #expect(Bool(false), "Label should exist")
            return
        }
        #expect(app.staticTexts["Irish"].exists)
        #expect(app.staticTexts["Pork"].exists)
        #expect(app.staticTexts["Ingredients"].exists)
        #expect(app.staticTexts["10 items"].exists)
        #expect(app.staticTexts["Bacon"].exists)
        #expect(app.staticTexts["Recipe"].exists)
        #expect(app.buttons["Link to the website"].exists)
    }
}
