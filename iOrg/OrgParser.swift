//
//  OrgParser.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class OrgParser {
    static func read(file: OrgFile) -> OrgDocument {
        // TODO: Investigate how efficient this is for very large files
        let fileText = try! String(contentsOf: file.path, encoding: .utf8)
        let lines = fileText.components(separatedBy: .newlines)
        return read(lines: lines)
    }

    static func read(lines: [String]) -> OrgDocument {
        return parse(tokens: lex(lines: lines))
    }

    static func lex(lines: [String]) -> [Token] {
        return lines.map({Token(line: $0)})
    }

    static func parse(tokens: [Token]) -> OrgDocument {
        let document = OrgDocument()

        return document
    }
}
