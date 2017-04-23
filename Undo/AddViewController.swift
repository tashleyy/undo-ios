//
//  AddViewController.swift
//  Undo
//
//  Created by Tiffany Tjahjadi on 4/21/17.
//  Copyright © 2017 Tiffany Tjahjadi. All rights reserved.
//

import UIKit
import Eureka

class AddViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section()
            <<< TextRow("nameRow") { row in
                row.title = "Name"
                row.placeholder = "Dominate the world"
            }
            <<< DateRow("dueDateRow") {
                $0.title = "Due Date"
                $0.value = Date(timeIntervalSinceNow: 0)
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
        
        TodoManager.sharedInstance.add(todo: Todo(name: name ?? "", dueDate: dueDate!))
        dismiss(animated: true, completion: nil)
    }
}
