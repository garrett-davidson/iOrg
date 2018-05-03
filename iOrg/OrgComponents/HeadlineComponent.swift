//
//  HeadlineComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/19/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation
import UIKit

class HeadlineComponent: OrgComponent {
    static let headlineFont = UIFont.boldSystemFont(ofSize: 40)
    static let headlineDefaultFontSize = 40
    static let headlineLevelFontSizeMultiplier = 7

    var headlineLevel: Int
    var todoKeyword: String?
    var priority: Character?
    var isCommented: Bool
    var title: String?
    var tags: [String]?
    var fontSize: CGFloat

    override init(withToken token: Token) {
        guard case let .Headline(headlineLevel, todoKeyword, priority, isCommented, title, tags) = token else {
            fatalError("Wrong token type")
        }

        self.headlineLevel = headlineLevel
        self.todoKeyword = todoKeyword
        self.priority = priority
        self.isCommented = isCommented
        self.title = title
        self.tags = tags

        self.fontSize = CGFloat(HeadlineComponent.headlineDefaultFontSize - (self.headlineLevel * HeadlineComponent.headlineLevelFontSizeMultiplier))

        super.init(withToken: token)
        self.height = self.fontSize * 1.5
    }

    override func formattedText() -> NSAttributedString {
        return attribute(self.title ?? "")
    }

    override func rawText() -> NSAttributedString {
        return attribute(rawString())
    }

    override func rawString() -> String {
        return leadingStars() ++ title
    }

    override func attribute(_ string: NSMutableAttributedString) -> NSMutableAttributedString {
        string.addAttribute(.font, value: HeadlineComponent.headlineFont.withSize(self.fontSize), range: string.string.range)

        return string
    }

    internal func leadingStars() -> String {
        return String(repeating: "*", count: headlineLevel)
    }

    override func relation(to otherComponent: OrgComponent) -> OrgComponent.TreeRelation {
        if let otherHeadline = otherComponent as? HeadlineComponent {
            let currentHeadlineLevel = self.headlineLevel
            let otherHeadlineLevel = otherHeadline.headlineLevel
            if currentHeadlineLevel == otherHeadlineLevel {
                return .SameGeneration
            } else if currentHeadlineLevel < otherHeadlineLevel {
                return .Ancestor
            } else {
                return .Progeny
            }
        } else {
            if otherComponent is PlainListItemComponent {
                return .Progeny
            } else if otherComponent is LineComponent {
                return .Ancestor
            }

            fatalError("Not implemented")
        }
    }
}
