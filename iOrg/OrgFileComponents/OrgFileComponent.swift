//
//  OrgFileComponent.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class OrgFileComponent: Equatable {
    var modified = false
    var children = [OrgFileComponent]()

    static func ==(lhs: OrgFileComponent, rhs: OrgFileComponent) -> Bool {
        guard type(of: lhs) == type(of: rhs) else {
            return false
        }

        guard lhs.children.count == rhs.children.count else {
            return false
        }

        for (leftChild, rightChild) in zip(lhs.children, rhs.children) {
            guard leftChild == rightChild else {
                return false
            }

            guard leftChild.isEqual(to: rightChild) else {
                return false
            }
        }

        return true
    }

    internal init() {
        self.modified = false
        self.children = []
    }

    // This method exists to handle polymorphic oddities.
    // == is static dispatch, while isEqual(to:) is dynamic.
    // Subclasses should _always_ override isEqual(to:), and should _always_ call super's implementation.
    // When actually comparing objects, _always_ use ==.
    internal func isEqual(to: OrgFileComponent) -> Bool {
        return true
    }
}
