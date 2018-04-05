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
    override func draw(component: OrgComponent, editing: Bool = false) {
        guard let line = component as? LineComponent else {
            fatalError("Wrong component")
        }

        self.backgroundColor = .orange

        super.draw(component: component, editing: editing)
    }
}
