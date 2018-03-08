//
//  OrgParserTests.swift
//  iOrgTests
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import XCTest
@testable import iOrg

class OrgParserTests: XCTestCase {
    func testSimpleHeadings() {
        let document = OrgHeadingComponent(title: "Document", headingLevel: 0)

        var lines = ["* Make it work"]
        document.children = [OrgHeadingComponent(title: "Make it work", headingLevel: 1)]
        var parsedDocument = OrgParser.parse(lines: lines)
        XCTAssertEqual(document, parsedDocument)

        lines = ["** Make it work"]
        document.children = [OrgHeadingComponent(title: "Make it work", headingLevel: 2)]
        parsedDocument = OrgParser.parse(lines: lines)
        XCTAssertEqual(document, parsedDocument)

        lines = ["* Make it work",
                 "** Make it work better"]
        document.children = [OrgHeadingComponent(title: "Make it work", headingLevel: 1)]
        document.children[0].children = [OrgHeadingComponent(title: "Make it work better", headingLevel: 2)]
        parsedDocument = OrgParser.parse(lines: lines)
        XCTAssertEqual(document, parsedDocument)

        lines = ["* Make it work",
                 "* Make it work better"]
        document.children = [OrgHeadingComponent(title: "Make it work", headingLevel: 1), OrgHeadingComponent(title: "Make it work better", headingLevel: 1)]
        parsedDocument = OrgParser.parse(lines: lines)
        XCTAssertEqual(document, parsedDocument)

        lines = ["* Make it work",
                 "** Make it work better",
                 "* Make it work faster"]
        document.children = [OrgHeadingComponent(title: "Make it work", headingLevel: 1), OrgHeadingComponent(title: "Make it work faster", headingLevel: 1)]
        document.children[0].children = [OrgHeadingComponent(title: "Make it work better", headingLevel: 2)]
        parsedDocument = OrgParser.parse(lines: lines)
        XCTAssertEqual(document, parsedDocument)

        lines = ["* Make it work",
                 "** Make it work better",
                 "",
                 "* Make it work faster"]
        document.children = [OrgHeadingComponent(title: "Make it work", headingLevel: 1), OrgHeadingComponent(title: "Make it work faster", headingLevel: 1)]
        document.children[0].children = [OrgHeadingComponent(title: "Make it work better", headingLevel: 2)]
        parsedDocument = OrgParser.parse(lines: lines)
        XCTAssertEqual(document, parsedDocument)
    }
}
