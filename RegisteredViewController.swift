//
//  RegisteredViewController.swift
//  Noticar
//
//  Created by Tanut.leel on 11/18/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import Material

class RegisteredViewController: UIViewController{

    @IBOutlet weak var userTextField: TextField!
    @IBOutlet weak var passTextField: TextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func signUP(_ sender: AnyObject) {
        FIRAuth.auth()?.createUser(withEmail: userTextField.text!, password: passTextField.text!, completion: {
            user , error in
            if error != nil{
                AppDelegate.showAlertMsg(withViewController: self, message: (error?.localizedDescription)!)
            }
            else{
                user?.sendEmailVerification()
                let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "editProfile")
                self.present(editProfile!, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func ResetPw(_ sender: Any) {
        let resetPasswordAlert = UIAlertController(title: "Reset Password", message: nil, preferredStyle: .alert)
        resetPasswordAlert.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter your email"
            textField.clearButtonMode = .whileEditing
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action: UIAlertAction) in
            let textField = resetPasswordAlert.textFields![0]
            
            FIRAuth.auth()?.sendPasswordReset(withEmail: textField.text!) { error in
                if let error = error {
                    AppDelegate.showAlertMsg(withViewController: self, message: error.localizedDescription)
                } else {
                    AppDelegate.showAlertMsg(withViewController: self, message: "Password reset email was sent")
                }
            }
        }
        
        resetPasswordAlert.addAction(cancelAction)
        resetPasswordAlert.addAction(confirmAction)
        self.present(resetPasswordAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userTextField.becomeFirstResponder()
        self.userTextField.delegate = self
        self.passTextField.delegate = self

    }

}

// MARK : TextFieldDelegate
extension RegisteredViewController : TextFieldDelegate {
    
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
