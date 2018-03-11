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
    func testWhitespaceTokenizer() {
        var lines = [""]
        var token = Token.whitespace
        var lexedToken = try! OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["   "]
        token = Token.whitespace
        lexedToken = try! OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["  "]
        token = Token.whitespace
        lexedToken = try! OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)
    }

    func testHeadlineTokenizer() {
        var lines = ["* Make it work"]
        var token = Token.headline(level: 1, todoKeyword: nil, priority: nil, comment: false, title: "Make it work", tags: nil)
        var lexedToken = try! OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["** Make it work"]
        token = Token.headline(level: 2, todoKeyword: nil, priority: nil, comment: false, title: "Make it work", tags: nil)
        lexedToken = try! OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["* TODO Make it work"]
        token = Token.headline(level: 1, todoKeyword: "TODO", priority: nil, comment: false, title: "Make it work", tags: nil)
        lexedToken = try! OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["* DONE Make it work"]
        token = Token.headline(level: 1, todoKeyword: "DONE", priority: nil, comment: false, title: "Make it work", tags: nil)
        lexedToken = try! OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["* todo Make it work"]
        token = Token.headline(level: 1, todoKeyword: nil, priority: nil, comment: false, title: "todo Make it work", tags: nil)
        lexedToken = try! OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["*"]
        token = Token.headline(level: 1, todoKeyword: nil, priority: nil, comment: false, title: nil, tags: nil)
        lexedToken = try! OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["* DONE"]
        token = Token.headline(level: 1, todoKeyword: "DONE", priority: nil, comment: false, title: nil, tags: nil)
        lexedToken = try! OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["*** Some e-mail"]
        token = Token.headline(level: 3, todoKeyword: nil, priority: nil, comment: false, title: "Some e-mail", tags: nil)
        lexedToken = try! OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["**** TODO [#A] COMMENT Title :tag:a2%:"]
        token = Token.headline(level: 4, todoKeyword: "TODO", priority: "A", comment: true, title: "Title", tags: ["tag", "a2%"])
        lexedToken = try! OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)
    }
}
