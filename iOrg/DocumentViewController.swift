//
//  DocumentViewController.swift
//  iOrg
//
//  Created by Garrett Davidson on 3/18/18.
//  Copyright © 2018 Garrett Davidson. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var document: OrgDocument?
    @IBOutlet weak var tableVIew: UITableView!

    override func viewDidLoad() {
        tableVIew.register(HeadlineCell.self, forCellReuseIdentifier: HeadlineComponent.getType())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                self.tableVIew.reloadData()
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return document?.components.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = document!.components[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: component.getType()) as? OrgUIComponentCell else {
            fatalError("Could not load cell")
        }

        cell.draw(component: component)

        return cell
    }
}
