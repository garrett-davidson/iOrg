//
//  OrgFileComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

protocol OrgFileComponent {
    var modified: Bool { get set }
    var children: [OrgFileComponent] { get set }
}
