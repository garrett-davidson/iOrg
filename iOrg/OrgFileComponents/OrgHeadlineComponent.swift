//
//  OrgHeadlineComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class OrgHeadlineComponent: OrgFileComponent {
    var title: String

    init(title: String) {
        self.title = title
        super.init()
    }

    override func isEqual(to other: OrgFileComponent) -> Bool {
        guard let other = other as? OrgHeadlineComponent else {
            assertionFailure("Should not be able to be run")
            return false
        }

        guard self.title == other.title else {
            return false
        }

        return super.isEqual(to: other)
    }
}
