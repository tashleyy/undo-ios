//
//  CalendarViewController.swift
//  Undo
//
//  Created by Tiffany Tjahjadi on 4/21/17.
//  Copyright © 2017 Tiffany Tjahjadi. All rights reserved.
//

import Foundation
import UIKit

class CalendarViewController: UIViewController, UINavigationBarDelegate {
    @IBOutlet weak var navBar: UINavigationBar!

    override func viewDidLoad() {
        navBar.delegate = self
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }

    @IBAction func togglePressed(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}
