//
//  CategoriesViewTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 13/01/2023.
//

import SwiftUI
import XCTest
@testable import foodie

final class CategoriesViewTest: XCTestCase {
    
    let timeout = 2.0
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testTimestampExistance() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let timestamp = app.staticTexts["TimestampLabel"]
        XCTAssertTrue(timestamp.waitForExistence(timeout: timeout))
        
    }
    
    func testTimestampValue() throws {
        // given
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        let timestamp = app.staticTexts["TimestampLabel"]

        //when
        XCTAssertTrue(timestamp.waitForExistence(timeout: timeout))

        // then
        XCTAssertNotEqual(timestamp.label, "")
    }
    
    
    

    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
    }
}
