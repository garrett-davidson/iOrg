//
//  OrgTODOComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class OrgTODOComponent: OrgHeadingComponent {
    enum OrgTODOState: Equatable {
        case TODO
        case DONE
        case Custom(String)

        static func ==(lhs: OrgTODOComponent.OrgTODOState, rhs: OrgTODOComponent.OrgTODOState) -> Bool {
            switch (lhs, rhs) {
            case (.TODO, .TODO): fallthrough
            case (.DONE, .DONE): return true
            case (.Custom(let left), .Custom(let right)):
                return left == right

            default:
                return false
            }
        }
    }

    var state: OrgTODOState
    var closeDate: Date?

    init(title: String, headingLevel: Int, state: OrgTODOState, closeDate: Date? = nil) {
        self.state = state
        self.closeDate = closeDate

        super.init(title: title, headingLevel: headingLevel)
    }

    override func isEqual(to other: OrgFileComponent) -> Bool {
        guard let other = other as? OrgTODOComponent else {
            assertionFailure("Should not be able to be run")
            return false
        }

        guard self.state == other.state else {
            return false
        }

        guard self.closeDate == other.closeDate else {
            return false
        }

        return super.isEqual(to: other)
    }
}
