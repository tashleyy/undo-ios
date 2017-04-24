//
//  LoginViewController.swift
//  Undo
//
//  Created by Tiffany Tjahjadi on 4/20/17.
//  Copyright © 2017 Tiffany Tjahjadi. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        loginButton.readPermissions = ["email"]
        loginButton.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if ((FBSDKAccessToken.current()) != nil) {
            moveToNext()
        }
    }
    
    func moveToNext() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let tvc: UITabBarController = storyboard.instantiateViewController(withIdentifier: "tabVC") as! UITabBarController
        present(tvc, animated: false, completion: nil)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (error != nil) {
            print("\(error)")
        } else if (result.token != nil) {
            moveToNext()
        } else {
            print("FAILURE")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) { }
}
