//
//  HeadlineCell.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/18/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation
import UIKit

class HeadlineCell: UITableViewCell, OrgUIComponentCell {
    init() {
        super.init(style: .default, reuseIdentifier: "HeadlineCell")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func draw(token: Token) {

    }
}
