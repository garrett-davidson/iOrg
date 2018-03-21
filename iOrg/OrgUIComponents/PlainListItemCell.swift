//
//  PlainListItemCell.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/20/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation
import UIKit

class PlainListItemCell: OrgUIComponentCell {

    override func draw(component: OrgComponent) {
        guard let item = component as? PlainListItemComponent else {
            fatalError("Wrong component")
        }

        self.textLabel?.text = item.contents
    }
}
