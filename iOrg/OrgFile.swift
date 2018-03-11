//
//  OrgFile.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class OrgFile {
    let path: URL
    var document: OrgDocument?

    init(file: URL) {
        self.path = file
    }
}
