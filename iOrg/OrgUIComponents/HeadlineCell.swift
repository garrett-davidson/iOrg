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
    static let headlineFont = UIFont.boldSystemFont(ofSize: 40)
    static let headlineDefaultFontSize = 40
    static let headlineLevelFontSizeMultiplier = 7

    override func draw(component: OrgComponent) {
        guard let headline = component as? HeadlineComponent else {
            fatalError("Wrong component")
        }

        let fontSize = CGFloat(HeadlineCell.headlineDefaultFontSize - (headline.headlineLevel * HeadlineCell.headlineLevelFontSizeMultiplier))
        headline.height = fontSize * 1.5
        self.textLabel?.font = HeadlineCell.headlineFont.withSize(fontSize)
        self.textLabel?.text = headline.title
    }
}
