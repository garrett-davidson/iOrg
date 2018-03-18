//
//  OrgDocumentViewController.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/18/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import Foundation
import UIKit

class OrgDocumentViewController: UIViewController, UIDocumentPickerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var openFileButton: UIButton!

    @IBAction func openFile(_ sender: Any) {
        let picker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .open)
        picker.delegate = self
        self.present(picker, animated: true) {
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!

        return cell
    }
}
