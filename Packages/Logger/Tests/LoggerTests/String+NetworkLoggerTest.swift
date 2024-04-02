//
//  String+NetworkLoggerTest.swift
//  
//
//  Created by Konrad Groschang on 10/06/2023.
//

import XCTest
@testable import Logger

final class StringNetworkLoggerTest: XCTestCase {

    func testRequest() {
        // Arrange
        var request = URLRequest(url: URL(string: "https://sample.com/gray?p=test")! )
        request.httpMethod = "GET"
        request.setValue("value1", forHTTPHeaderField: "f2")
        request.setValue("value2", forHTTPHeaderField: "f0")
        request.httpBody = Data("test".utf8)

        // Act
        let log = "\(request: request)"

        // Asset
        let output = """
        URL: https://sample.com/gray?p=test
        GET https sample.com ? p=test
        HTTP Headers:
          f0 : value2
          f2 : value1
        BODY:
          test
        """

        XCTAssertEqual(log, output)
    }

    func testResponseSuccess() {
        // Arrange
        let response: URLResponse = HTTPURLResponse(url: URL(string: "sample.com")!,
                                                    statusCode: 200,
                                                    httpVersion: nil,
                                                    headerFields: nil)!
        let output = "StatusCode: 200"

        // Act
        let log = "\(response: response)"

        print(log)

        // Asset
        XCTAssertEqual(log, output)
    }

    func testResponseNonHTTPURLResponse() {
        // Arrange
        let response = URLResponse()

        // Act
        let log = "\(response: response)"

        // Asset
        XCTAssertEqual(log, "")
    }

    func testData() {
        // Arrange
        let json = """
        {"id":1,"title":"the title","description":"description"}
        """

        let data = Data(json.utf8)

        let output = """
        JSON:
        {
          "id" : 1,
          "title" : "the title",
          "description" : "description"
        }
        """

        // Act
        let log = "\(data: data)"

        // Asset
        XCTAssertEqual(log, output)
    }
}
