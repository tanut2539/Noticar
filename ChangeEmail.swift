//
//  ChangeEmail.swift
//  Noticar
//
//  Created by Tanut.leel on 11/20/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChangeEmail: UITableViewController{

    @IBOutlet weak var changeEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeEmail.becomeFirstResponder()
        
        let DoneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveEmail))
        navigationItem.rightBarButtonItem = DoneButton
        
        if let user = FIRAuth.auth()?.currentUser {
            setUserDataToView(withFIRUser: user)
        }
        
        self.changeEmail.delegate = self
        
        prepareNavigationItem()
    }
    
    private func prepareNavigationItem() {
        navigationItem.title = "Change Email"
    }
    
    func setUserDataToView(withFIRUser user: FIRUser) {
        changeEmail.text = user.email
    }
    
    func logout() {
        try! FIRAuth.auth()!.signOut()
        let loginNav = self.storyboard?.instantiateViewController(withIdentifier: "signIn")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginNav
    }
    
    func saveEmail(){
        let user = FIRAuth.auth()?.currentUser
        user?.updateEmail(changeEmail.text!) { error in
            if let error = error {
                AppDelegate.showAlertMsg(withViewController: self, message: error.localizedDescription)
            } else {
                AppDelegate.showAlertMsg(withViewController: self, message: "Email was updated. You have to login again.")
                self.logout()
            }
        }
    }
    
}

// MARK : TextField Delegate
extension ChangeEmail : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        changeEmail.resignFirstResponder()
        return true
    }
    
}
