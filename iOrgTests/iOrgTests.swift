//
//  iOrgTests.swift
//  iOrgTests
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import XCTest
@testable import iOrg

class iOrgTests: XCTestCase {
    func testPolymorphicEquality() {
        var left = OrgHeadingComponent(title: "My title", headingLevel: 0)
        var right = OrgHeadingComponent(title: "My title", headingLevel: 0)
        XCTAssertEqual(left, right)

        left = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .TODO, closeDate: nil)
        right = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .TODO, closeDate: nil)
        XCTAssertEqual(left, right)

        left = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("In progress"), closeDate: nil)
        right = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("In progress"), closeDate: nil)
        XCTAssertEqual(left, right)

        let now = Date()
        left = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("In progress"), closeDate: now)
        right = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("In progress"), closeDate: now)
        XCTAssertEqual(left, right)

        left = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .TODO, closeDate: nil)
        right = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .DONE, closeDate: nil)
        XCTAssertNotEqual(left, right)

        left = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("In progress"), closeDate: nil)
        right = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("Other"), closeDate: nil)
        XCTAssertNotEqual(left, right)

        left = OrgHeadingComponent(title: "Stuff", headingLevel: 0)
        right = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .DONE, closeDate: nil)
        XCTAssertNotEqual(left, right)

        let notNow = Date(timeIntervalSince1970: 0)
        left = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("In progress"), closeDate: now)
        right = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("In progress"), closeDate: notNow)
        XCTAssertNotEqual(left, right)

        left = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("In progress"), closeDate: nil)
        right = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("In progress"), closeDate: nil)
        var leftChild = OrgTODOComponent(title: "Kid stuff", headingLevel: 0, state: .TODO, closeDate: nil)
        var rightChild = OrgTODOComponent(title: "Kid stuff", headingLevel: 0, state: .TODO, closeDate: nil)
        left.children = [leftChild]
        right.children = [rightChild]
        XCTAssertEqual(left, right)

        left = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("In progress"), closeDate: nil)
        right = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("In progress"), closeDate: nil)
        leftChild = OrgTODOComponent(title: "Kid stuff", headingLevel: 0, state: .TODO, closeDate: nil)
        rightChild = OrgTODOComponent(title: "Kid stuff", headingLevel: 0, state: .TODO, closeDate: nil)
        left.children = [leftChild, leftChild]
        right.children = [rightChild]
        XCTAssertNotEqual(left, right)

        left = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("In progress"), closeDate: nil)
        right = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .Custom("In progress"), closeDate: nil)
        leftChild = OrgTODOComponent(title: "Big kid stuff", headingLevel: 0, state: .TODO, closeDate: nil)
        rightChild = OrgTODOComponent(title: "Kid stuff", headingLevel: 0, state: .TODO, closeDate: nil)
        left.children = [leftChild]
        right.children = [rightChild]
        XCTAssertNotEqual(left, right)

        left = OrgHeadingComponent(title: "My title", headingLevel: 0)
        right = OrgHeadingComponent(title: "My title", headingLevel: 1)
        XCTAssertNotEqual(left, right)

        left = OrgTODOComponent(title: "Stuff", headingLevel: 0, state: .TODO, closeDate: nil)
        right = OrgTODOComponent(title: "Stuff", headingLevel: 1, state: .DONE, closeDate: nil)
        XCTAssertNotEqual(left, right)
    }
}
