//
//  TodoManager.swift
//  Undo
//
//  Created by Tiffany Tjahjadi on 4/21/17.
//  Copyright © 2017 Tiffany Tjahjadi. All rights reserved.
//

import UIKit

class TodoManager: NSObject {
    class func get() -> [Todo] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        var result: [Todo] = []
        result.append(Todo(name: "to do 1", dueDate: formatter.date(from: "2017/04/21")!))
        result.append(Todo(name: "to do 2", dueDate: formatter.date(from: "2017/04/22")!))
        return result
    }
}
