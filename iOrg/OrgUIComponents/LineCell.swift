//
//  LineCell.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/19/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation
import UIKit

class LineCell: OrgUIComponentCell {
    override func draw(component: OrgComponent) {
        guard let line = component as? LineComponent else {
            fatalError("Wrong component")
        }

        self.textLabel?.text = line.text
        self.backgroundColor = .orange
    }
}
