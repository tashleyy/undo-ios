//
//  SettingsViewController.swift
//  Undo
//
//  Created by Tiffany Tjahjadi on 4/24/17.
//  Copyright © 2017 Tiffany Tjahjadi. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit

class SettingsViewController: UIViewController, FBSDKLoginButtonDelegate {
    var logoutButton: FBSDKLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton = FBSDKLoginButton()
        logoutButton.center = view.center
        view.addSubview(logoutButton)
        logoutButton.readPermissions = ["email"]
        logoutButton.delegate = self
    }

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) { }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let pvc = self.presentingViewController
        dismiss(animated: true) { 
            pvc?.dismiss(animated: false, completion: nil)
        }
    }
}
