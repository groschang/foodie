//
//  MealsServiceTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 12/01/2023.
//

import XCTest
@testable import foodie

final class MealsServiceTest: XCTestCase {
    
    var backendClient: APIClientMock!
    var persistanceClient: CoreDataClientMock!
    var sut: MealsService!
    
    override func setUp() {
        backendClient = APIClientMock()
        persistanceClient = CoreDataClientMock()
        sut = MealsService(backendClient: backendClient!,
                           persistanceClient: persistanceClient!)
    }

    override func tearDown() {
        backendClient = nil
        persistanceClient = nil
        sut = nil
    }

    func testGetCategories() async throws {
//        let categories = try await sut.getCategories()
            
//        XCTAssertEqual(categories.items.last?.name, "Pork")
    }
    
    func testGetCocktails() async throws {
//        let cocktailsInfo  = try await sut.getCocktails(for: "Juice")
//        let foodInfo = DrinkInfo.mock
//
//        XCTAssertEqual(cocktailsInfo.infos.first, foodInfo)
    }

    func testGetCocktail() async throws {
//        let cocktailDetail  = try await sut.getCocktail(for: "2")
//
//        XCTAssertEqual(cocktailDetail.name, "Vodka Slime")
//        XCTAssertEqual(cocktailDetail.ingredients.first?.name, "Sprite")
    }
}
