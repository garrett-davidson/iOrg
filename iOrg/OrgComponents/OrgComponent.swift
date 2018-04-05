//
//  OrgComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/19/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation
import UIKit

class OrgComponent {
    weak var parent: OrgComponent?
    var children: [OrgComponent]?

    var indentationLevel = 0
    var height: CGFloat = 20

    internal init(withToken token: Token) {
        // Intentionally empty
    }

    static func from(token: Token) -> OrgComponent? {
        switch token {
        case let .Headline(_, todoKeyword, _, _, _, _):
            if todoKeyword == nil {
                return HeadlineComponent(withToken: token)
            } else {
                return TODOComponent(withToken: token)
            }
        case .Line:
            return LineComponent(withToken: token)
        case .PlainListItem:
            return PlainListItemComponent(withToken: token)
        default:
            return nil
        }
    }

    func formattedText() -> String {
        return ""
    }

    func rawText() -> String {
        return ""
    }

    func getType() -> String {
        return String(describing: type(of: self))
    }

    static func getType() -> String {
        return String(describing: self)
    }
}
