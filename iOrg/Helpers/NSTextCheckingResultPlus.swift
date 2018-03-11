//
//  NSTextCheckingResultPlus.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/11/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

extension NSTextCheckingResult {
    subscript(index: Int) -> NSRange? {
        let range = self.range(at: index)
        return range.location == NSNotFound ? nil : range
    }

    func trimmedMatch(at range: Int, in string: String) -> String? {
        if let range = self[range] {
            return string[range]?.trimmed()
        } else {
            return nil
        }
    }
}
