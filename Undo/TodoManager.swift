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
    var todos: [Todo] = []
    var subscriptions: [() -> ()] = []

    private override init() { }
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference().child("todos")
    }
    
    func download() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"

        self.ref.observeSingleEvent(of: .value, with: { snapshot in
            var result: [Todo] = []
            for todoSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                guard let todo = todoSnapshot.value as? [String: String] else { continue }
                result.append(Todo(name: todo["name"]!, dueDate: formatter.date(from: todo["dueDate"]!)!))
            }
            self.todos = result
            self.processSubscriptions()
        })
    }
    
    func upload() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        var value: [[String: String]] = [];
        for todo in todos {
            value.append(["name": todo.name, "dueDate": formatter.string(from: todo.dueDate)])
        }
        ref.setValue(value)
    }

    func get() -> [Todo] {
        return todos
    }
    
    func add(todo: Todo) {
        todos.append(todo)
        processSubscriptions()
    }
    
    func subscribe(callback: @escaping () -> ()) {
        subscriptions.append(callback)
    }
    
    func processSubscriptions() {
        for subscription in self.subscriptions { subscription() }
    }
}
