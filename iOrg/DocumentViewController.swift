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
    var currentlyEditingIndexPath: IndexPath?
    @IBOutlet weak var tableView: UITableView!

    var doneButton: UIBarButtonItem!
    var saveButton: UIBarButtonItem!

    override func viewDidLoad() {
        tableView.register(HeadlineCell.self, forCellReuseIdentifier: HeadlineComponent.getType())
        tableView.register(LineCell.self, forCellReuseIdentifier: LineComponent.getType())
        tableView.register(PlainListItemCell.self, forCellReuseIdentifier: PlainListItemComponent.getType())
        tableView.register(TODOCell.self, forCellReuseIdentifier: TODOComponent.getType())

        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.finishEditing(_:)))
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveDocument(_:)))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = saveButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                self.tableView.reloadData()
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
        let row = indexPath.row
        let component = document!.components[row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: component.getType()) as? OrgUIComponentCell else {
            fatalError("Could not load cell")
        }

        cell.draw(component: component, editing: currentlyEditingIndexPath == indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indicesToUpdate: [IndexPath]
        if let finishedEditingIndexPath = currentlyEditingIndexPath {
            indicesToUpdate = [finishedEditingIndexPath, indexPath]
        } else {
            indicesToUpdate = [indexPath]
        }
        currentlyEditingIndexPath = indexPath

        tableView.reloadRows(at: indicesToUpdate, with: .automatic)

        guard let cell = tableView.cellForRow(at: indexPath) as? OrgUIComponentCell else {
            fatalError()
        }

        cell.textField.becomeFirstResponder()
        cell.textField.keyboardDismissMode = .onDrag
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = doneButton
    }

    @objc func saveDocument(_ sender: Any) {
        document!.savePresentedItemChanges { (error) in
            guard error == nil else {
                fatalError("Error saving document")
            }
        }
    }

    @objc func finishEditing(_ sender: Any) {
        guard let currentlyEditingIndexPath = currentlyEditingIndexPath else {
            fatalError("This button should not be displayed")
        }

        guard let cell = tableView.cellForRow(at: currentlyEditingIndexPath) as? OrgUIComponentCell else {
            fatalError("Could not fetch cell")
        }

        self.currentlyEditingIndexPath = nil
        cell.textField.resignFirstResponder()
        tableView.reloadRows(at: [currentlyEditingIndexPath], with: .automatic)

        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = saveButton
    }
}
