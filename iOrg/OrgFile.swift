//
//  OrgFile.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class OrgFile {
    let fileName: String
    var isParsed = false
    var components = [OrgFileComponent]()

    init(file: String) {
        self.fileName = file
    }
}
