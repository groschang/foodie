//
//  CategoriesTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 13/01/2023.
//

import XCTest
@testable import foodie

final class CategoriesTest: XCTestCase {
    
    func testInitialization() {
        let categories = Categories(items: [.mock])
        XCTAssertEqual(categories.items.first, Category.mock)
    }
}
