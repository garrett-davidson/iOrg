//
//  OrgDocument.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/9/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import UIKit

class OrgDocument: UIDocument {
    var components = [OrgComponent]()

    override init(fileURL url: URL) {
        super.init(fileURL: url)
    }

    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents dataContents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        guard let dataContents = dataContents as? Data, let contents = String(data: dataContents, encoding: .utf8) else {
            return
        }

        let tokens = OrgParser.lex(lines: contents.split(separator: "\n").map({String($0)}))
        self.components = OrgParser.parse(tokens: tokens)
    }
}

