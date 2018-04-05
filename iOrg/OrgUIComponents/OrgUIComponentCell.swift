//
//  OrgUIComponentCell.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/18/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation
import UIKit

class OrgUIComponentCell: UITableViewCell {
    var textField: UITextView

    func draw(component: OrgComponent) {
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.textField = UITextView(frame: CGRect.zero)
        self.textField.isScrollEnabled = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(textField)

        self.contentView.addConstraint(NSLayoutConstraint(item: self.textField, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .topMargin, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.textField, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottomMargin, multiplier: 1, constant: 0))

        self.contentView.addConstraint(NSLayoutConstraint(item: self.textField, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leadingMargin, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: .trailingMargin, relatedBy: .equal, toItem: self.textField, attribute: .trailing, multiplier: 1, constant: 0))
        self.textField.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
