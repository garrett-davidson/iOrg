//
//  HeadlineCell.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/18/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation
import UIKit

class HeadlineCell: OrgUIComponentCell {
    let headlineFont = UIFont.boldSystemFont(ofSize: 40)

    override func draw(component: OrgComponent) {
        guard let headline = component as? HeadlineComponent else {
            fatalError("Wrong component")
        }

        self.textLabel?.font = headlineFont
        self.textLabel?.text = headline.title
    }
}
