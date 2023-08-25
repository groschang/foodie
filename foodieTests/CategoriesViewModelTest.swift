//
//  CategoriesViewModelTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 13/01/2023.
//

import XCTest
@testable import foodie

@MainActor
final class CategoriesViewModelTest: XCTestCase {
    
    var service: MealsServiceMock!
    var sut: CategoriesViewModel!
    
    override func setUp() {
        super.setUp()
        service = MealsServiceMock(delay: true)
//        sut = CategoriesViewModel(service: service as! MealsServiceVType)
    }
    
    func testFetchCategories() async {
//        await sut.load()
//        
//        XCTAssertEqual(sut.items.first?.name, "Beef")
//        XCTAssertEqual(sut.items.last?.name, "Pork")
    }
}
