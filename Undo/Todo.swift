//
//  Todo.swift
//  Undo
//
//  Created by Tiffany Tjahjadi on 4/21/17.
//  Copyright © 2017 Tiffany Tjahjadi. All rights reserved.
//

import UIKit

class Todo: NSObject {
    var name: String
    var dueDate: Date
    
    init(name: String, dueDate: Date) {
        self.name = name
        self.dueDate = dueDate
        super.init()
    }
}
