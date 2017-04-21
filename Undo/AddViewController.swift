//
//  AddViewController.swift
//  Undo
//
//  Created by Tiffany Tjahjadi on 4/21/17.
//  Copyright © 2017 Tiffany Tjahjadi. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UINavigationBarDelegate {
    @IBOutlet weak var navBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.delegate = self
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func savePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
