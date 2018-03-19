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
    var priority: Character?
    var isCommented: Bool
    var title: String?
    var tags: [String]?

    override init(withToken token: Token) {
        guard case let .Headline(headlineLevel, todoKeyword, priority, isCommented, title, tags) = token else {
            fatalError("Wrong token type")
        }

        assert(todoKeyword == nil)

        self.headlineLevel = headlineLevel
        self.priority = priority
        self.isCommented = isCommented
        self.title = title
        self.tags = tags

        super.init(withToken: token)
    }
}
