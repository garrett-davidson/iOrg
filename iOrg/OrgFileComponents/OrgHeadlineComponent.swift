//
//  OrgHeadlineComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class OrgHeadlineComponent: OrgFileComponent {
    var modified: Bool
    var children: [OrgFileComponent]

    init(title: String) {
        self.modified = false
        self.children = []
    }
}
