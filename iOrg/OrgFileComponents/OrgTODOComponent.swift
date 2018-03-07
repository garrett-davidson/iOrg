//
//  OrgTODOComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class OrgTODOComponent: OrgHeadlineComponent {
    enum OrgTODOState {
        case TODO
        case DONE
        case Custom(String)
    }

    var state: OrgTODOState
    var closeDate: Date?

    init(title: String, state: OrgTODOState, closeDate: Date?) {
        self.state = state
        self.closeDate = closeDate

        super.init(title: title)
    }
}
