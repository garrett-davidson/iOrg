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
    enum TreeRelation {
        case Ancestor
        case Progeny
        case SameGeneration
    }

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

    func insert(child: OrgComponent, at index: Int = 0) {
        assert(child.parent == nil)

        if self.children == nil {
            self.children = [child]
        } else {
            self.children!.insert(child, at: index)
        }

        child.parent = self
    }

    @discardableResult func insert(child: OrgComponent, after sibling: OrgComponent) -> Bool {
        child.parent = self

        return self.children!.insert(child, after: sibling)
    }

    func describeTree(indentation: String = "") -> String {
        let description = indentation + self.description
        guard let children = self.children else { return description }

        return ([description] + children.map({$0.describeTree(indentation: indentation + "  ")})).joined(separator: "\n")
    }

    func describeFullTree() -> String {
        return getRoot().describeTree()
    }

    func getRoot() -> OrgComponent {
        var parent = self
        while let p = parent.parent {
            parent = p
        }

        return parent
    }

    func relation(to otherComponent: OrgComponent) -> TreeRelation {
        fatalError("Override me")
    }
}
