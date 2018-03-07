//
//  OrgHeadlineComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class OrgHeadingComponent: OrgFileComponent {
    var title: String
    var headingLevel: Int

    init(title: String, headingLevel: Int) {
        self.title = title
        self.headingLevel = headingLevel
        super.init()
    }

    override func isEqual(to other: OrgFileComponent) -> Bool {
        guard let other = other as? OrgHeadingComponent else {
            assertionFailure("Should not be able to be run")
            return false
        }

        guard self.title == other.title else {
            return false
        }

        return super.isEqual(to: other)
    }
}
