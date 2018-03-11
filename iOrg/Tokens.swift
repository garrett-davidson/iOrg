//
//  Tokens.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/8/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

let tokenizers: [Tokenizer] = [WhitespaceTokenizer(), HeadlineTokenizer()]
struct TokenizerError: Error {

}

enum Token: Equatable {
    case whitespace
    case headline(level: Int, todoKeyword: String?, priority: Character?, comment: Bool, title: String?, tags: [String]?)

    init(line: String) throws {
        for tokenizer in tokenizers {
            if let token = tokenizer.tokenFrom(line: line) {
                self = token
                return
            }
        }

        throw TokenizerError()
    }

    static func ==(lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
        case (.whitespace, .whitespace):
            return true
        case (.headline(let leftLevel, let leftTODOKeyword, let leftPriority, let leftComment, let leftTitle, let leftTags), .headline(let rightLevel, let rightTODOKeyword, let rightPriority, let rightComment, let rightTitle, let rightTags)):
            guard leftTags?.count == rightTags?.count else {
                return false
            }

            if leftTags != nil && rightTags != nil {
                if leftTags! != rightTags! {
                    return false
                }
            }

            return leftLevel == rightLevel
                && leftTODOKeyword == rightTODOKeyword
                && leftPriority == rightPriority
                && leftComment == rightComment
                && leftTitle == rightTitle
        default:
            return false
        }
    }
}

protocol Tokenizer {
    func tokenFrom(line: String) -> Token?
}

struct WhitespaceTokenizer: Tokenizer {
    static let regex = try! NSRegularExpression(pattern: "^\\s*$")
    func tokenFrom(line: String) -> Token? {
        guard line.matches(for: WhitespaceTokenizer.regex).count > 0 else {
            return nil
        }

        return .whitespace
    }
}

struct HeadlineTokenizer: Tokenizer {
    static let todoKeywords = ["TODO", "DONE"]
    static let regex = try! NSRegularExpression(pattern: "^(\\*+)( (TODO|DONE))?( \\[\\#([A-Z])\\])?( COMMENT)?( .+?)?( :.+:)?$")
    let regex = try! NSRegularExpression(pattern: "\\*+ \(HeadlineTokenizer.todoKeywords.joined(separator: "|"))")

    enum MatchRange: Int {
        case Stars = 1
        case TODO = 2
        case Priority = 5
        case Comment = 6
        case Title = 7
        case Tags = 8
    }

    func tokenFrom(line: String) -> Token? {
        guard let matches = line.matches(for: HeadlineTokenizer.regex).first else {
            return nil
        }

        let starCount = matches.trimmedMatch(at: MatchRange.Stars.rawValue, in: line)!.count
        let todoKeyword = matches.trimmedMatch(at: MatchRange.TODO.rawValue, in: line)
        let priority = matches.trimmedMatch(at: MatchRange.Priority.rawValue, in: line)?.first
        let comment = matches.trimmedMatch(at: MatchRange.Comment.rawValue, in: line) != nil
        let title = matches.trimmedMatch(at: MatchRange.Title.rawValue, in: line)
        let tags = matches.trimmedMatch(at: MatchRange.Tags.rawValue, in: line)?.split(separator: ":").flatMap({return $0.count > 0 ? String($0) : nil})

        return Token.headline(level: starCount, todoKeyword: todoKeyword, priority: priority, comment: comment, title: title, tags: tags)
    }
}
