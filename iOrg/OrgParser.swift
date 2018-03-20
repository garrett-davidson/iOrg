//
//  OrgParser.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class OrgParser {
    static func lex(lines: [String]) -> [Token] {
        return lines.map({Token(line: $0)})
    }

    // TODO: Properly handle multiline footnotes https://orgmode.org/worg/dev/org-syntax.html#Footnote_Definitions
    // TODO: Properly handle inline footnotes https://orgmode.org/manual/Footnotes.html
    static func parse(tokens: [Token]) -> [OrgComponent] {
        var components = [OrgComponent]()
        for token in tokens {
            guard let component = OrgComponent.from(token: token) else {
                fatalError("Could not match token")
            }

            components.append(component)
        }

        return components
    }
}
