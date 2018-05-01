//
//  TODOComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/19/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class TODOComponent: HeadlineComponent {
    static let doneKeyword = "DONE"

    var isChecked = false

    override func rawText() -> String {
        return leadingStars() ++ todoKeyword ++ title
    }

    internal func checkbox() -> String {
        return isChecked ? "[X]" : "[ ]"
    }
}
