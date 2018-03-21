//
//  Tokens.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/8/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation

let tokenizers: [Tokenizer] = [WhitespaceTokenizer(), HeadlineTokenizer(), BeginBlockTokenizer(), EndBlockTokenizer(), DrawerTokenizer(), BeginDynamicBlockTokenizer(), EndDynamicBlockTokenizer(), BeginFootnoteTokenizer(), PlainListItemTokenizer()]

enum Token: Equatable {
    case Whitespace
    case Headline(level: Int, todoKeyword: String?, priority: Character?, comment: Bool, title: String?, tags: [String]?)
    case BeginBlock(title: String, parameters: String?)
    case EndBlock(title: String)
    case BeginDrawer(title: String)
    case EndDrawer
    case BeginDynamicBlock(title: String, parameters: String?)
    case EndDynamicBlock
    case BeginFootnote(label: String, contents: String)
    case PlainListItem(bullet: String, checked: Bool?, tag: String?, contents: String?)

    case Line(text: String)

    init(line: String) {
        for tokenizer in tokenizers {
            if let token = tokenizer.tokenFrom(line: line) {
                self = token
                return
            }
        }

        self = .Line(text: line)
    }

    static func ==(lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
        case (.Whitespace, .Whitespace):
            return true
        case (.Headline(let leftLevel, let leftTODOKeyword, let leftPriority, let leftComment, let leftTitle, let leftTags), .Headline(let rightLevel, let rightTODOKeyword, let rightPriority, let rightComment, let rightTitle, let rightTags)):
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

        case (.BeginBlock(let leftTitle, let leftParameters), .BeginBlock(let rightTitle, parameters: let rightParameters)):
            return leftTitle == rightTitle
                && leftParameters == rightParameters

        case (.EndBlock(let leftTitle), .EndBlock(let rightTitle)):
            return leftTitle == rightTitle

        case (.BeginDrawer(let leftTitle), .BeginDrawer(let rightTitle)):
            return leftTitle == rightTitle

        case (.EndDrawer, .EndDrawer):
            return true

        case (.BeginDynamicBlock(let leftTitle, let leftParameters), .BeginDynamicBlock(let rightTitle, let rightParameters)):
            return leftTitle == rightTitle
                && leftParameters == rightParameters

        case (.EndDynamicBlock, .EndDynamicBlock):
            return true

        case (let .BeginFootnote(leftLabel, leftContents), let .BeginFootnote(rightLabel, rightContents)):
            return leftLabel == rightLabel
                && leftContents == rightContents

        case (let .PlainListItem(leftBullet, leftChecked, leftTag, leftContents), let .PlainListItem(rightBullet, rightChecked, rightTag, rightContents)):
            return leftBullet == rightBullet
                && leftChecked == rightChecked
                && leftTag == rightTag
                && leftContents == rightContents

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

        return .Whitespace
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

        return Token.Headline(level: starCount, todoKeyword: todoKeyword, priority: priority, comment: comment, title: title, tags: tags)
    }
}

struct BeginBlockTokenizer: Tokenizer {
    static let regex = try! NSRegularExpression(pattern: "^\\#\\+BEGIN_(\\S+)( .+)?$", options: .caseInsensitive)

    enum MatchRange: Int {
        case Title = 1
        case Parameters = 2
    }

    func tokenFrom(line: String) -> Token? {
        guard let matches = line.matches(for: BeginBlockTokenizer.regex).first else {
            return nil
        }

        let title = matches.trimmedMatch(at: MatchRange.Title.rawValue, in: line)!
        let parameters = matches.trimmedMatch(at: MatchRange.Parameters.rawValue, in: line)

        return .BeginBlock(title: title, parameters: parameters)
    }
}

struct EndBlockTokenizer: Tokenizer {
    static let regex = try! NSRegularExpression(pattern: "^\\#\\+end_(\\S+)$", options: .caseInsensitive)

    enum MatchRange: Int {
        case Title = 1
    }

    func tokenFrom(line: String) -> Token? {
        guard let matches = line.matches(for: EndBlockTokenizer.regex).first else {
            return nil
        }

        let title = matches.trimmedMatch(at: MatchRange.Title.rawValue, in: line)!

        return .EndBlock(title: title)
    }
}

struct DrawerTokenizer: Tokenizer {
    static let regex = try! NSRegularExpression(pattern: "^:([A-Za-z\\-_]+):$")

    enum MatchRange: Int {
        case Title = 1
    }

    func tokenFrom(line: String) -> Token? {
        guard let matches = line.matches(for: DrawerTokenizer.regex).first else {
            return nil
        }

        let title = matches.trimmedMatch(at: MatchRange.Title.rawValue, in: line)!

        return title.uppercased() == "END" ? .EndDrawer : .BeginDrawer(title: title)
    }
}

struct BeginDynamicBlockTokenizer: Tokenizer {
    static let regex = try! NSRegularExpression(pattern: "^\\#\\+BEGIN: (\\S+)( .+)?$", options: .caseInsensitive)

    enum MatchRange: Int {
        case Title = 1
        case Parameters = 2
    }

    func tokenFrom(line: String) -> Token? {
        guard let matches = line.matches(for: BeginDynamicBlockTokenizer.regex).first else {
            return nil
        }

        let title = matches.trimmedMatch(at: MatchRange.Title.rawValue, in: line)!
        let parameters = matches.trimmedMatch(at: MatchRange.Parameters.rawValue, in: line)

        return .BeginDynamicBlock(title: title, parameters: parameters)
    }
}

struct EndDynamicBlockTokenizer: Tokenizer {
    static let regex = try! NSRegularExpression(pattern: "^\\#\\+END:$", options: .caseInsensitive)

    func tokenFrom(line: String) -> Token? {
        guard line.matches(for: EndDynamicBlockTokenizer.regex).count > 0 else {
            return nil
        }

        return .EndDynamicBlock
    }
}

struct BeginFootnoteTokenizer: Tokenizer {
    static let regex = try! NSRegularExpression(pattern: "^\\[fn:([0-9]+|[a-zA-Z\\-_]+)\\]( .+)?", options: .caseInsensitive)

    enum MatchRange: Int {
        case Label = 1
        case Contents = 2
    }

    func tokenFrom(line: String) -> Token? {
        guard let matches = line.matches(for: BeginFootnoteTokenizer.regex).first else {
            return nil
        }

        let label = matches.trimmedMatch(at: MatchRange.Label.rawValue, in: line)!
        let contents = matches.trimmedMatch(at: MatchRange.Contents.rawValue, in: line) ?? ""

        return .BeginFootnote(label: label, contents: contents)
    }
}

struct PlainListItemTokenizer: Tokenizer {
    static let regex = try! NSRegularExpression(pattern: "^\\s+([*\\-+]|([0-9]+|[A-Za-z])(\\.|\\)))( \\[( |X)\\])?( (.+) ::)?( .+)?$", options: .caseInsensitive)

    enum MatchRange: Int {
        case Bullet = 1
        case Checkmark = 5
        case Tag = 7
        case Contents = 8
    }

    func tokenFrom(line: String) -> Token? {
        guard let matches = line.matches(for: PlainListItemTokenizer.regex).first else {
            return nil
        }

        let bullet = matches.trimmedMatch(at: MatchRange.Bullet.rawValue, in: line)!

        let checked: Bool?
        if let checkmark = matches.trimmedMatch(at: MatchRange.Checkmark.rawValue, in: line) {
            checked = checkmark == "X"
        } else {
            checked = nil
        }

        let tag = matches.trimmedMatch(at: MatchRange.Tag.rawValue, in: line)
        let contents = matches.trimmedMatch(at: MatchRange.Contents.rawValue, in: line)

        return .PlainListItem(bullet: bullet, checked: checked, tag: tag, contents: contents)
    }
}
