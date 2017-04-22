//
//  TodoManager.swift
//  Undo
//
//  Created by Tiffany Tjahjadi on 4/21/17.
//  Copyright © 2017 Tiffany Tjahjadi. All rights reserved.
//

import UIKit
import Firebase

class TodoManager: NSObject {
    static let sharedInstance = TodoManager()
    var ref: FIRDatabaseReference!

    private override init() { }
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference().child("todos")
    }
    
    func get(withCompletion callback: @escaping ([Todo]) -> ()) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"

        self.ref.observeSingleEvent(of: .value, with: { snapshot in
            var result: [Todo] = []
            for todoSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                guard let todo = todoSnapshot.value as? [String:String] else { continue }
                result.append(Todo(name: todo["name"]!, dueDate: formatter.date(from: todo["dueDate"]!)!))
            }
            callback(result)
        })
    }
}
