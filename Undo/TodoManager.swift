//
//  TodoManager.swift
//  Undo
//
//  Created by Tiffany Tjahjadi on 4/21/17.
//  Copyright © 2017 Tiffany Tjahjadi. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit

class TodoManager: NSObject {
    static let sharedInstance = TodoManager()
    var ref: FIRDatabaseReference!
    var todos: [Todo] = []
    var subscriptions: [() -> ()] = []
    let formatter = DateFormatter()

    private override init() { }
    
    func configureDatabase() {
        let graphRequest = FBSDKGraphRequest(graphPath: "/me?fields=email", parameters: nil)
        graphRequest?.start(completionHandler: { (connection, result, error) in
            if (error != nil) {
                print(error!)
            } else {
                let resultDict = result as! [String: Any]
                print(resultDict)
                self.ref = FIRDatabase.database().reference().child(resultDict["id"] as! String)
                self.download()
            }
        })
    }
    
    func download() {
        formatter.dateFormat = "yyyy/MM/dd"

        let device = UIDevice.current
        guard device.isMultitaskingSupported else {
            print("Multitasking not supported on this device.")
            return
        }
        var bTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
        bTask = UIApplication.shared.beginBackgroundTask(expirationHandler: { 
            UIApplication.shared.endBackgroundTask(bTask)
            bTask = UIBackgroundTaskInvalid
        })
        let serialQueue = DispatchQueue(label: "downloadQueue")
        serialQueue.async {
            self.ref.observeSingleEvent(of: .value, with: { snapshot in
                var result: [Todo] = []
                for todoSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    guard let todo = todoSnapshot.value as? [String: String] else { continue }
                    result.append(Todo(name: todo["name"]!, dueDate: self.formatter.date(from: todo["dueDate"]!)!))
                }
                self.todos = result
                self.processSubscriptions()

                UIApplication.shared.endBackgroundTask(bTask)
                bTask = UIBackgroundTaskInvalid
            })
        }
    }
    
    func upload() {
        formatter.dateFormat = "yyyy/MM/dd"

        let device = UIDevice.current
        guard device.isMultitaskingSupported else {
            print("Multitasking not supported on this device.")
            return
        }
        var bTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
        bTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask(bTask)
            bTask = UIBackgroundTaskInvalid
        })
        let serialQueue = DispatchQueue(label: "uploadQueue")
        serialQueue.async {
            var value: [[String: String]] = [];
            for todo in self.todos {
                value.append(["name": todo.name, "dueDate": self.formatter.string(from: todo.dueDate)])
            }
            self.ref.setValue(value)

            UIApplication.shared.endBackgroundTask(bTask)
            bTask = UIBackgroundTaskInvalid
        }
    }

    func get() -> [Todo] {
        return todos
    }
    
    func add(todo: Todo) {
        todos.append(todo)
        processSubscriptions()
    }
    
    func edit(todo: Todo, atIndex index: Int) {
        todos[index] = todo
        processSubscriptions()
    }
    
    func delete(index: Int) {
        todos.remove(at: index)
        processSubscriptions()
    }
    
    func subscribe(callback: @escaping () -> ()) {
        subscriptions.append(callback)
    }
    
    func processSubscriptions() {
        for subscription in subscriptions { subscription() }
    }
}
