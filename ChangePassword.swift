//
//  ChangePassword.swift
//  Noticar
//
//  Created by Tanut.leel on 11/19/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChangePassword : UITableViewController{
    
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newPasswordAgian: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let DoneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(changePassword))
        navigationItem.rightBarButtonItem = DoneButton
        
        currentPassword.delegate = self
        newPassword.delegate = self
        newPasswordAgian.delegate = self
        
    }
    
    func changePassword() {
        let user = FIRAuth.auth()?.currentUser
            user?.updatePassword(newPassword.text!) { error in
                if let error = error {
                    AppDelegate.showAlertMsg(withViewController: self, message: error.localizedDescription)
                } else {
                    AppDelegate.showAlertMsg(withViewController: self, message: "Password was updated")
                }
            }
    }
    
}

// MARK : TextField Delegate
extension ChangePassword : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        currentPassword.resignFirstResponder()
        newPassword.resignFirstResponder()
        newPasswordAgian.resignFirstResponder()
        return true
    }

}
