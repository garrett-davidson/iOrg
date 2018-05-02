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
        var currentParent = OrgComponent.from(token: Token.Headline(level: 0, todoKeyword: nil, priority: nil, comment: false, title: nil, tags: nil))!

        var components = [currentParent]

        for token in tokens {
            guard let newComponent = OrgComponent.from(token: token) else {
                fatalError("Could not match token")
            }

            switch (token) {
            case .Whitespace:
                currentParent.add(child: newComponent)
            case .Headline(let newLevel, _, _, _, _, _):
                if let currentHeadline = currentParent as? HeadlineComponent {
                    let currentLevel = currentHeadline.headlineLevel
                    if currentLevel == newLevel {
                        newComponent.add(parent: currentParent.parent!)
                        currentParent = newComponent
                    } else if (currentLevel < newLevel) {
                        currentParent.add(child: newComponent)
                        currentParent = newComponent
                    } else {
                        var newComponentParent = currentParent
                        while let p = newComponentParent.parent as? HeadlineComponent, p.headlineLevel >= newLevel {
                            newComponentParent = p
                        }

                        newComponent.add(parent: newComponentParent.parent!)
                        currentParent = newComponent
                    }
                } else {
                    fatalError("Not implemented")
                }
            case .BeginBlock(_, _):
                fatalError("Not implemented")
            case .EndBlock(_):
                fatalError("Not implemented")
            case .BeginDrawer(_):
                fatalError("Not implemented")
            case .EndDrawer:
                fatalError("Not implemented")
            case .BeginDynamicBlock(_, _):
                fatalError("Not implemented")
            case .EndDynamicBlock:
                fatalError("Not implemented")
            case .BeginFootnote(_, _):
                fatalError("Not implemented")
            case .PlainListItem(let currentLeadingWhitespace, _, _, _, _):
                if let currentHeadline = currentParent as? HeadlineComponent {
                    currentHeadline.add(child: newComponent)
                } else if let currentPlainListItem = currentParent as? PlainListItemComponent {
                    let newPlainListItem = newComponent as! PlainListItemComponent
                    let newLeadingWhitespace = currentPlainListItem.leadingWhitespace
                    if currentLeadingWhitespace.count == newLeadingWhitespace.count {
                        let newParent = currentPlainListItem.parent!
                        newPlainListItem.add(parent: newParent)
                        currentParent = newPlainListItem
                    } else if currentLeadingWhitespace.count > newLeadingWhitespace.count {
                        currentPlainListItem.add(child: newComponent)
                        currentParent = newPlainListItem
                    } else {
                        var newComponentParent = currentParent
                        while let p = newComponentParent.parent as? PlainListItemComponent, p.leadingWhitespace.count >= newLeadingWhitespace.count {
                            newComponentParent = p
                        }

                        newComponent.add(parent: newComponentParent.parent!)
                    }
                } else {
                    fatalError("Not implemented")
                }
            case .Line(_):
                currentParent.add(child: newComponent)
            }

            components.append(newComponent)
        }

        return components
    }
}
