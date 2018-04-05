//
//  PlainListItemComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/20/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class PlainListItemComponent: OrgComponent {
    var bullet: String
    var checked: Bool?
    var tag: String?
    var contents: String?

    var formattedBullet = "•"

    override init(withToken token: Token) {
        guard case let .PlainListItem(bullet, checked, tag, contents) = token else {
            fatalError("Wrong token type")
        }

        self.bullet = bullet
        self.checked = checked
        self.tag = tag
        self.contents = contents

        super.init(withToken: token)
    }

    override func formattedText() -> String {
        return formattedBullet + " " + (contents ?? "")
    }

    override func rawText() -> String {
        return bullet + " " + (contents ?? "")
    }
}
