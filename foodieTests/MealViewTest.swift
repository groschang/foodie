//
//  MealViewTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 15/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import XCTest
import Nimble
import ViewInspector
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

        let viewModel = MealAsyncStreamViewModel.stub

        expect(viewModel.area).to(equal("Irish"))
        expect(viewModel.name).to(equal("Coddled pork with cider"))
        expect(viewModel.category).to(equal("Pork"))

        let view = MealView(viewModel: viewModel)
    }

}
