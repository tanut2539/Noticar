//
//  LoginViewController.swift
//  Noticar
//
//  Created by Tanut.leel on 11/18/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import FirebaseAuth
import Material

class LoginViewController: UIViewController{

    @IBAction func prepareForUnWind(segue: UIStoryboardSegue) {
        
    }
    
    var authListener: FIRAuthStateDidChangeListenerHandle?

    @IBOutlet weak var userTextField: TextField!
    @IBOutlet weak var passTextField: TextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userTextField.becomeFirstResponder()
        self.userTextField.delegate = self
        self.passTextField.delegate = self

    }

    @IBAction func Login(sender: AnyObject) {
        //login()
        FIRAuth.auth()?.signIn(withEmail: userTextField.text!, password: passTextField.text!) { (user, error) in
            if let error = error {
                AppDelegate.showAlertMsg(withViewController: self, message: error.localizedDescription)
            }
            else{
                let mainView = self.storyboard?.instantiateViewController(withIdentifier: "MainView")
                self.present(mainView!, animated: false, completion: nil)
            }
        }
    }

}

// MARK : TextFieldDelegate
extension LoginViewController : TextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: TextField) {
        scrollView.setContentOffset((CGPoint(x: 0, y: 50)), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: TextField) {
        scrollView.setContentOffset((CGPoint(x: 0, y: 0)), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: TextField) -> Bool {
        userTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
