//
//  MealViewTest.swift
//  foodie
//
//  Created by Konrad Groschang on 15/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import XCTest
import Nimble
@testable import foodie

final class MealViewTest: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["testing"]
        app.launch()
    }

    func testElementsExistence() {
        // Given
        /// Select mocked meal (all are equal)
        let label = app.staticTexts["Foodie of the day"]

        // When
        expect(label.waitForExistence(timeout: 5)).to(beTrue())
        label.tap()

        // Then
        let titleLabel = app.staticTexts["Coddled pork with cider"]
        expect(titleLabel.waitForExistence(timeout: 5)).to(beTrue())
        expect(self.app.staticTexts["Irish"].exists).to(beTrue())
        expect(self.app.staticTexts["Pork"].exists).to(beTrue())
        expect(self.app.staticTexts["Ingredients"].exists).to(beTrue())
        expect(self.app.staticTexts["10 items"].exists).to(beTrue())
        expect(self.app.staticTexts["Bacon"].exists).to(beTrue())
        expect(self.app.staticTexts["Recipe"].exists).to(beTrue())
        let recipeTextView = app.staticTexts["RecipeTextView"]
        expect(recipeTextView.exists).to(beTrue())
        expect(recipeTextView.label.contains("STEP 2")).to(beTrue())
        expect(self.app.buttons["Link to the website"].exists).to(beTrue())
    }

}
