//
//  OrgParser.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/7/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

class OrgParser {
    static func parse(file: OrgFile) -> OrgHeadingComponent {
        // TODO: Investigate how efficient this is for very large files
        let fileText = try! String(contentsOf: file.path, encoding: .utf8)
        let lines = fileText.components(separatedBy: .newlines)
        return parse(lines: lines)
    }

    static func parse(lines: [String]) -> OrgHeadingComponent {
        let documentRoot = OrgHeadingComponent(title: "Document", headingLevel: 0)
        var headingQueue = [documentRoot]

        var lineNumber = 0
        
        while lineNumber < lines.count {
            let currentLine = lines[lineNumber]
            lineNumber += 1
            guard let firstCharacter = currentLine.first else {
                continue
            }

            switch firstCharacter {
            case "*":
                guard let newHeading = parseHeading(currentLine) else {
                    break
                }

                let previousHeading = headingQueue.last!

                if previousHeading.headingLevel < newHeading.headingLevel {
                    // Example
                    // * previousHeading
                    // ** newHeading
                    headingQueue.append(newHeading)
                    previousHeading.children.append(newHeading)
                } else if previousHeading.headingLevel == newHeading.headingLevel {
                    // Example
                    // ** previousHeading
                    // ** newHeading

                    assert(headingQueue.count > 1)
                    headingQueue.removeLast()

                    headingQueue.last!.children.append(newHeading)

                    headingQueue.append(newHeading)
                } else {
                    // Example
                    // ** previousHeading
                    // * newHeading

                    assert(headingQueue.count > 1)
                    headingQueue.removeLast(2)

                    headingQueue.last!.children.append(newHeading)

                    headingQueue.append(newHeading)
                }
            default:
                break
            }
        }

        return documentRoot
    }

    static func parseHeading(_ line: String) -> OrgHeadingComponent? {
        var headingLevel = 0

        while line[line.index(line.startIndex, offsetBy: headingLevel)] == "*" {
            headingLevel += 1
        }

        let title = line[line.index(line.startIndex, offsetBy: headingLevel)...].trimmingCharacters(in: .whitespaces)

        return OrgHeadingComponent(title: title, headingLevel: headingLevel)
    }
}
