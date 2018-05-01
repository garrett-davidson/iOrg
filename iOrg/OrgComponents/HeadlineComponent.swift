//
//  HeadlineComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/19/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class HeadlineComponent: OrgComponent {
    var headlineLevel: Int
    var todoKeyword: String?
    var priority: Character?
    var isCommented: Bool
    var title: String?
    var tags: [String]?

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

        super.init(withToken: token)
    }

    override func formattedText() -> String {
        return self.title ?? ""
    }

    override func rawText() -> String {
        return String(repeating: "*", count: headlineLevel) + " " + (title ?? "")
    }
}
