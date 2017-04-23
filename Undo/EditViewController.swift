//
//  EditViewController.swift
//  Undo
//
//  Created by Tiffany Tjahjadi on 4/21/17.
//  Copyright © 2017 Tiffany Tjahjadi. All rights reserved.
//

import UIKit
import Eureka

class EditViewController: FormViewController {
    var index: Int?
    var initialName: String?
    var initialDueDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section()
            <<< TextRow("nameRow") { row in
                row.title = "Name"
                row.value = initialName!
            }
            <<< DateRow("dueDateRow") {
                $0.title = "Due Date"
                $0.value = initialDueDate!
            }
            <<< ButtonRow("deleteTodo") {
                $0.title = "Delete Todo"
            }
        
        let buttonRow: ButtonRow? = form.rowBy(tag: "deleteTodo")
        buttonRow?.onCellSelection { cell, row in
            self.deletePressed()
        }
    }

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func savePressed(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let name = (form.rowBy(tag: "nameRow") as? TextRow)?.value
        let dueDate = (form.rowBy(tag: "dueDateRow") as? DateRow)?.value

        TodoManager.sharedInstance.edit(todo: Todo(name: name ?? "", dueDate: dueDate!), atIndex: index!)
        dismiss(animated: true, completion: nil)
    }
    
    func deletePressed() {
        TodoManager.sharedInstance.delete(index: index!)
        dismiss(animated: true, completion: nil)
    }
}
