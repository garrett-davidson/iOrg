//
//  StringPlus.swift
//  iOrgTests
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

extension String {
    func dropFirstWord() -> Substring {
        let trimmedSelf = self.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let whitespaceIndex = trimmedSelf.index(where: {CharacterSet.whitespacesAndNewlines.contains($0.unicodeScalars.first!)}) else {
            return ""
        }

        return trimmedSelf[trimmedSelf.index(after: whitespaceIndex)...]
    }
}
