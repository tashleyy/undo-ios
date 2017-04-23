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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section()
            <<< TextRow() { row in
                row.title = "Name"
                row.value = "Dominate the world"
            }
            <<< DateRow() {
                $0.title = "Due Date"
                $0.value = Date(timeIntervalSinceNow: 0)
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
        dismiss(animated: true, completion: nil)
    }
    
    func deletePressed() {
        dismiss(animated: true, completion: nil)
    }
}
