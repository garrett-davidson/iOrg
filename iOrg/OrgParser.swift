//
//  OrgParser.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class OrgParser {
    static func read(file: OrgFile) throws -> OrgDocument {
        // TODO: Investigate how efficient this is for very large files
        let fileText = try! String(contentsOf: file.path, encoding: .utf8)
        let lines = fileText.components(separatedBy: .newlines)
        return try read(lines: lines)
    }

    static func read(lines: [String]) throws -> OrgDocument {
        return parse(tokens: try lex(lines: lines))
    }

    static func lex(lines: [String]) throws -> [Token] {
        return try lines.map({try Token(line: $0)})
    }

    static func parse(tokens: [Token]) -> OrgDocument {
        let document = OrgDocument()

        return document
    }
}
