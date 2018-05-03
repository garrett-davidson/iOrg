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
        var currentComponent = OrgComponent.from(token: Token.Headline(level: 0, todoKeyword: nil, priority: nil, comment: false, title: nil, tags: nil))!
        var components = [currentComponent]

        for token in tokens {
            guard let newComponent = OrgComponent.from(token: token) else {
                fatalError("Could not match token")
            }

            self.insert(newComponent, after: currentComponent)
            components.append(newComponent)
            currentComponent = newComponent
        }

        return components
    }

    static func insert(_ newComponent: OrgComponent, after currentComponent: OrgComponent) {
        switch newComponent.relation(to: currentComponent) {
        case .Ancestor:
            guard let sibling = currentComponent.parent, let parent = sibling.parent else {
                currentComponent.printFullTree()
                fatalError("Tree is broken")
            }

            guard parent.insert(child: newComponent, after: sibling) else {
                sibling.printFullTree()
                fatalError("Tree is probably broken")
            }
        case .Progeny:
            currentComponent.insert(child: newComponent)
        case .SameGeneration:
            guard let parent = currentComponent.parent else {
                currentComponent.printFullTree()
                fatalError("Tree is broken")
            }

            guard parent.insert(child: newComponent, after: currentComponent) else {
                currentComponent.printFullTree()
                fatalError("Tree is probably broken")
            }
        }
    }
}
