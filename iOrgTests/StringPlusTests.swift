//
//  StringPlusTests.swift
//  iOrgTests
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import XCTest
@testable import iOrg

class StringPlusTests: XCTestCase {
    func testDropFirstWord() {
        var testString = "My test string"
        var output = "test string"
        XCTAssertEqual(String(testString.dropFirstWord()), output)

        testString = "1 test string"
        output = "test string"
        XCTAssertEqual(String(testString.dropFirstWord()), output)

        testString = " test string"
        output = "string"
        XCTAssertEqual(String(testString.dropFirstWord()), output)

        testString = "string"
        output = ""
        XCTAssertEqual(String(testString.dropFirstWord()), output)

        testString = " string"
        output = ""
        XCTAssertEqual(String(testString.dropFirstWord()), output)

        testString = "     "
        output = ""
        XCTAssertEqual(String(testString.dropFirstWord()), output)

        testString = ""
        output = ""
        XCTAssertEqual(String(testString.dropFirstWord()), output)
    }
}
