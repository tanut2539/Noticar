//
//  MainViewController.swift
//  Noticar
//
//  Created by TOEY on 11/4/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class MainViewController: UIViewController, FBSDKLoginButtonDelegate{

    @IBAction func prepareForUnWind(segue: UIStoryboardSegue) {
        
    }
    
    var authListener: FIRAuthStateDidChangeListenerHandle?
    var loginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //frame's are obselete, please use constraints instead because its 2016 after all
        loginButton.readPermissions = ["email", "public_profile"]
        loginButton.frame = CGRect(x: 0, y: 0, width: 240, height: 38)
        loginButton.center = view.center;
        loginButton.delegate = self
        view.addSubview(loginButton)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authListener = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if let _ = user {
                let mainView = self.storyboard?.instantiateViewController(withIdentifier: "MainView")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = mainView
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user , error) in
            let mainView = self.storyboard?.instantiateViewController(withIdentifier: "editProfile")
            self.present(mainView!, animated: false, completion: nil)
        }
    }
    
    /*!
     @abstract Sent to the delegate when the button was used to logout.
     @param loginButton The button that was clicked.
     */
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User did Logout!")
    }
    
}
