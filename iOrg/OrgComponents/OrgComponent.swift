//
//  OrgComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/19/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation
import UIKit

class OrgComponent: CustomStringConvertible {
    var description: String {
        return String(describing: type(of: self)) + ": " + self.rawText()
    }

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

    func add(child: OrgComponent) {
        assert(child.parent == nil)

        if self.children == nil {
            self.children = [child]
        } else {
            self.children!.append(child)
        }

        child.parent = self
    }

    func add(parent: OrgComponent) {
        parent.add(child: self)
    }

    func printTree(indentation: String = "") {
        print(indentation + self.description)
        guard let children = self.children else { return }

        children.forEach({$0.printTree(indentation: indentation + "  ")})
    }

    func printFullTree() {
        getRoot().printTree()
    }

    func getRoot() -> OrgComponent {
        var parent = self
        while let p = parent.parent {
            parent = p
        }

        return parent
    }
}
