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

    @IBAction func addPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let avc: AddViewController = storyboard.instantiateViewController(withIdentifier: "addVC") as! AddViewController
        present(avc, animated: true, completion: nil)
    }
}