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
}
