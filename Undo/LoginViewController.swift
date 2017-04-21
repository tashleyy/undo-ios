//
//  LoginViewController.swift
//  Undo
//
//  Created by Tiffany Tjahjadi on 4/20/17.
//  Copyright © 2017 Tiffany Tjahjadi. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        loginButton.readPermissions = ["email"]
        loginButton.delegate = self
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (error != nil) {
            print("\(error)")
        } else if (result.token != nil) {
            print("Success, navigate away")
        } else {
            print("FAILURE")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) { }
}
