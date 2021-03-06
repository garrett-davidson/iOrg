//
//  LineComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/19/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class LineComponent: OrgComponent {
    var text: String

    override init(withToken token: Token) {
        guard case let .Line(text) = token else {
            fatalError("Wrong token type")
        }

        self.text = text
        super.init(withToken: token)
    }

    override func formattedText() -> NSAttributedString {
        return attribute(self.text)
    }

    override func rawText() -> NSAttributedString {
        return attribute(rawString())
    }

    override func rawString() -> String {
        return self.text
    }

    override func relation(to otherComponent: OrgComponent) -> OrgComponent.TreeRelation {
        if otherComponent is HeadlineComponent {
            return .Progeny
        }

        fatalError("Not implemented")
    }
}
