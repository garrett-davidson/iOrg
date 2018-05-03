//
//  ArrayPlus.swift
//  iOrg
//
//  Created by Garrett Davidson on 5/2/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

extension Array where Element: AnyObject {
    /// Returns true if the `after` element exists in the array
    /// False otherwise
    @discardableResult mutating func insert(_ newElement: Element, after currentElement: Element) -> Bool {
        for (i, e) in self.enumerated() {
            if e === currentElement {
                if i == self.count - 1 {
                    self.append(newElement)
                } else {
                    self.insert(newElement, at: i+1)
                }

                return true
            }
        }

        self.append(currentElement)
        return false
    }
}
