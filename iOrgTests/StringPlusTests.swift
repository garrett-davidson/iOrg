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

    func testPlusPlusOperator() {
        var testString = "My test string"
        var output = "My test string"
        XCTAssertEqual(testString ++ nil, output)

        output = "My test string "
        XCTAssertEqual(testString ++ "", output)

        output = "My test string  "
        XCTAssertEqual(testString ++ " ", output)

        output = "My test string 2"
        XCTAssertEqual(testString ++ "2", output)

        output = "My test string 2 3"
        XCTAssertEqual(testString ++ "2" ++ "3", output)

        testString = "My"
        output = "My test string 2"
        XCTAssertEqual(testString ++ "test" ++ "string" ++ "2", output)

        testString = "My"
        output = "My test string 2"
        XCTAssertEqual(testString ++ nil ++ "test" ++ nil ++ nil ++ "string" ++ nil ++ "2" ++ nil, output)
    }
}
