//
//  APIClientTest.swift
//  foodieTests
//
//  Created by Konrad Groschang on 20/01/2023.
//

import XCTest
@testable import foodie

final class APIClientTest: XCTestCase {
    
    var apiClient: HTTPClient!

    override func setUpWithError() throws {
        super.setUp()
        apiClient = APIClient()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
    }


}
