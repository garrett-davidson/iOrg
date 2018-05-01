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
        var token = Token.Whitespace
        var lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["   "]
        token = Token.Whitespace
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["  "]
        token = Token.Whitespace
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)
    }

    func testHeadlineTokenizer() {
        var lines = ["* Make it work"]
        var token = Token.Headline(level: 1, todoKeyword: nil, priority: nil, comment: false, title: "Make it work", tags: nil)
        var lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["** Make it work"]
        token = Token.Headline(level: 2, todoKeyword: nil, priority: nil, comment: false, title: "Make it work", tags: nil)
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["* TODO Make it work"]
        token = Token.Headline(level: 1, todoKeyword: "TODO", priority: nil, comment: false, title: "Make it work", tags: nil)
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["* DONE Make it work"]
        token = Token.Headline(level: 1, todoKeyword: "DONE", priority: nil, comment: false, title: "Make it work", tags: nil)
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["* todo Make it work"]
        token = Token.Headline(level: 1, todoKeyword: nil, priority: nil, comment: false, title: "todo Make it work", tags: nil)
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["*"]
        token = Token.Headline(level: 1, todoKeyword: nil, priority: nil, comment: false, title: nil, tags: nil)
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["* DONE"]
        token = Token.Headline(level: 1, todoKeyword: "DONE", priority: nil, comment: false, title: nil, tags: nil)
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["*** Some e-mail"]
        token = Token.Headline(level: 3, todoKeyword: nil, priority: nil, comment: false, title: "Some e-mail", tags: nil)
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["**** TODO [#A] COMMENT Title :tag:a2%:"]
        token = Token.Headline(level: 4, todoKeyword: "TODO", priority: "A", comment: true, title: "Title", tags: ["tag", "a2%"])
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)
    }

    func testBeginBlock() {
        var lines = ["#+BEGIN_NAME"]
        var token = Token.BeginBlock(title: "NAME", parameters: nil)
        var lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+BEGIN_name"]
        token = Token.BeginBlock(title: "name", parameters: nil)
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+BEGIN_name parameters n stuff#$%^&*"]
        token = Token.BeginBlock(title: "name", parameters: "parameters n stuff#$%^&*")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+begin_name parameters n stuff#$%^&*"]
        token = Token.BeginBlock(title: "name", parameters: "parameters n stuff#$%^&*")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+bEgIN_name parameters n stuff#$%^&*"]
        token = Token.BeginBlock(title: "name", parameters: "parameters n stuff#$%^&*")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)
    }

    func testEndBlock() {
        var lines = ["#+END_NAME"]
        var token = Token.EndBlock(title: "NAME")
        var lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+END_name"]
        token = Token.EndBlock(title: "name")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+end_name"]
        token = Token.EndBlock(title: "name")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+eNd_name"]
        token = Token.EndBlock(title: "name")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)
    }

    func testDrawer() {
        var lines = [":my-drawer:"]
        var token = Token.BeginDrawer(title: "my-drawer")
        var lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = [":My-fANcY_dRAWeR:"]
        token = Token.BeginDrawer(title: "My-fANcY_dRAWeR")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = [":END:"]
        token = Token.EndDrawer
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = [":end:"]
        token = Token.EndDrawer
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)
    }

    func testBeginDynamucBlock() {
        var lines = ["#+BEGIN: NAME"]
        var token = Token.BeginDynamicBlock(title: "NAME", parameters: nil)
        var lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+BEGIN: name"]
        token = Token.BeginDynamicBlock(title: "name", parameters: nil)
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+BEGIN: name parameters n stuff#$%^&*"]
        token = Token.BeginDynamicBlock(title: "name", parameters: "parameters n stuff#$%^&*")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+begin: name parameters n stuff#$%^&*"]
        token = Token.BeginDynamicBlock(title: "name", parameters: "parameters n stuff#$%^&*")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+bEgIN: name parameters n stuff#$%^&*"]
        token = Token.BeginDynamicBlock(title: "name", parameters: "parameters n stuff#$%^&*")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)
    }

    func testEndDynamicBlock() {
        var lines = ["#+END:"]
        var token = Token.EndDynamicBlock
        var lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+end:"]
        token = Token.EndDynamicBlock
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+enD:"]
        token = Token.EndDynamicBlock
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["#+end :"]
        token = Token.EndDynamicBlock
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertNotEqual(token, lexedToken)

        lines = ["#+end: name"]
        token = Token.EndDynamicBlock
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertNotEqual(token, lexedToken)
    }

    func testBeginFootnote() {
        var lines = ["[fn:1] The link is: https://orgmode.org"]
        var token = Token.BeginFootnote(label: "1", contents: "The link is: https://orgmode.org")
        var lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["[fn:name]"]
        token = Token.BeginFootnote(label: "name", contents: "")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)
    }

    func testPlainListItem() {
        var lines = ["   1. Peter Jackson being shot by Legolas"]
        var token = Token.PlainListItem(leadingWhitespace: "", bullet: "1.", checked: nil, tag: nil, contents: "Peter Jackson being shot by Legolas")
        var lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["       A. The attack of the Rohirrim"]
        token = Token.PlainListItem(leadingWhitespace: "", bullet: "A.", checked: nil, tag: nil, contents: "The attack of the Rohirrim")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["       b) The attack of the Rohirrim"]
        token = Token.PlainListItem(leadingWhitespace: "", bullet: "b)", checked: nil, tag: nil, contents: "The attack of the Rohirrim")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["       c The attack of the Rohirrim"]
        lexedToken = OrgParser.lex(lines: lines)[0]
        if case Token.PlainListItem(_, _, _, _, _) = lexedToken {
            XCTFail()
        }

        lines = ["      + this was already my favorite scene in the book"]
        token = Token.PlainListItem(leadingWhitespace: "", bullet: "+", checked: nil, tag: nil, contents: "this was already my favorite scene in the book")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["       - on DVD only"]
        token = Token.PlainListItem(leadingWhitespace: "", bullet: "-", checked: nil, tag: nil, contents: "on DVD only")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["   - Elijah Wood :: He plays Frodo"]
        token = Token.PlainListItem(leadingWhitespace: "", bullet: "-", checked: nil, tag: "Elijah Wood", contents: "He plays Frodo")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["    2. [ ] item 2"]
        token = Token.PlainListItem(leadingWhitespace: "", bullet: "2.", checked: false, tag: nil, contents: "item 2")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["    3) [X] item 3"]
        token = Token.PlainListItem(leadingWhitespace: "", bullet: "3)", checked: true, tag: nil, contents: "item 3")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)

        lines = ["   - [ ] some tag :: item 2.1"]
        token = Token.PlainListItem(leadingWhitespace: "", bullet: "-", checked: false, tag: "some tag", contents: "item 2.1")
        lexedToken = OrgParser.lex(lines: lines)[0]
        XCTAssertEqual(token, lexedToken)
    }
}
