//
//  PlainListItemComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/20/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class PlainListItemComponent: OrgComponent {
    var leadingWhitespace: String
    var bullet: String
    var checked: Bool?
    var tag: String?
    var contents: String?

    var formattedBullet = "•"

    override init(withToken token: Token) {
        guard case let .PlainListItem(leadingWhitespace, bullet, checked, tag, contents) = token else {
            fatalError("Wrong token type")
        }

        self.leadingWhitespace = leadingWhitespace
        self.bullet = bullet
        self.checked = checked
        self.tag = tag
        self.contents = contents

        super.init(withToken: token)
    }

    override func formattedText() -> NSAttributedString {
        return attribute(formattedBullet + " " + (contents ?? ""))
    }

    override func rawText() -> NSAttributedString {
        return attribute(rawString())
    }

    override func rawString() -> String {
        return leadingWhitespace + bullet + " " + (contents ?? "")
    }

    override func relation(to otherComponent: OrgComponent) -> OrgComponent.TreeRelation {
        guard let otherPlainListItem = otherComponent as? PlainListItemComponent else {
            if otherComponent is HeadlineComponent {
                return .Progeny
            } else if otherComponent is LineComponent {
                return .Ancestor
            }

            fatalError("Not implemented")
        }
        let currentLeadingWhitespace = self.leadingWhitespace
        let otherLeadingWhitespace = otherPlainListItem.leadingWhitespace

        if currentLeadingWhitespace.count == otherLeadingWhitespace.count {
            return .SameGeneration
        } else if currentLeadingWhitespace.count > otherLeadingWhitespace.count {
            return .Progeny
        } else {
            return .Ancestor
        }
    }
}
