//
//  OrgElements.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/9/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class OrgDocument {
    let root = Token.headline(level: 0, todoKeyword: nil, priority: nil, comment: false, title: nil, tags: nil)
}
