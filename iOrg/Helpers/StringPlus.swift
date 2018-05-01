//
//  StringPlus.swift
//  iOrgTests
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

infix operator ++: AdditionPrecedence

extension String {
    var range: NSRange {
        get {
            return NSMakeRange(0, self.count)
        }
    }

    func dropFirstWord() -> Substring {
        let trimmedSelf = self.trimmed()
        guard let whitespaceIndex = trimmedSelf.index(where: {CharacterSet.whitespacesAndNewlines.contains($0.unicodeScalars.first!)}) else {
            return ""
        }

        return trimmedSelf[trimmedSelf.index(after: whitespaceIndex)...]
    }

    func firstWord() -> Substring? {
        let trimmedSelf = self.trimmed()
        guard let whitespaceIndex = trimmedSelf.index(where: {CharacterSet.whitespacesAndNewlines.contains($0.unicodeScalars.first!)}) else {
            return nil
        }

        return trimmedSelf[...trimmedSelf.index(before: whitespaceIndex)]
    }

    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func matches(for regex: NSRegularExpression) -> [NSTextCheckingResult] {
        return regex.matches(in: self, options: [], range: self.range)
    }

    subscript(range: NSRange) -> Substring? {
        guard let newRange = Range(range, in: self) else {
            return nil
        }

        return self[newRange]
    }

    static func ++(lhs: String, rhs: String?) -> String {
        return lhs + (rhs?.prepending(" ") ?? "")
    }

    func prepending(_ string: String) -> String {
        return string + self
    }
}

extension Substring {
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension Character {
    func belongs(to characterSet: CharacterSet) -> Bool {
        for scalar in self.unicodeScalars {
            guard characterSet.contains(scalar) else {
                return false
            }
        }

        return true
    }
}
