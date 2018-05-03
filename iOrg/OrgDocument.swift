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
        return self.components.map({$0.rawString()}).joined(separator: "\n").data(using: .utf8)!
    }
    
    override func load(fromContents dataContents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        guard let dataContents = dataContents as? Data, let contents = String(data: dataContents, encoding: .utf8) else {
            return
        }

        let tokens = OrgParser.lex(lines: contents.split(separator: "\n").map({String($0)}))
        self.components = OrgParser.parse(tokens: tokens)
    }

    override var hasUnsavedChanges: Bool {
        get {
            // TODO: Implement me properly
            return true
        }
    }

    override func savePresentedItemChanges(completionHandler: @escaping (Error?) -> Void) {
        // TODO: Implement me properly
        self.save(to: self.presentedItemURL!, for: .forOverwriting) { (didSucceed) in
            if didSucceed {
                completionHandler(nil)
            } else {
                completionHandler(nil)
            }
        }
    }
}
