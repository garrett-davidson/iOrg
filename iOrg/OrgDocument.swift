//
//  OrgDocument.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/9/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import UIKit

class OrgDocument: UIDocument {
    let root = Token.Headline(level: 0, todoKeyword: nil, priority: nil, comment: false, title: nil, tags: nil)

    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        guard let contents = contents as? String else {
            return
        }

        let tokens = OrgParser.lex(lines: contents.split(separator: "\n").map({String($0)}))
    }
}

