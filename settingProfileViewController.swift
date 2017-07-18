//
//  settingProfileViewController.swift
//  Noticar
//
//  Created by Tanut.leel on 11/21/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class settingsProfileViewController: UITableViewController{
    
    @IBOutlet weak var userDisplayName: UITextField!
    @IBOutlet weak var userDisplayEmail: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    let ref = FIRDatabase.database().reference().root
    
    @IBAction func changePhoto(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker.delegate = self
        
        let DoneButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveProfile))
        navigationItem.rightBarButtonItem = DoneButton
        
        if let user = FIRAuth.auth()?.currentUser {
            setUserDataToView(withFIRUser: user)
        }
        
        self.userDisplayName.delegate = self
        self.userDisplayEmail.delegate = self
        
        prepareNavigationItem()
    }
    
    private func prepareNavigationItem() {
        navigationItem.title = "Edit Profile"
    }
    
    func setUserDataToView(withFIRUser user: FIRUser) {
        userDisplayName.text = user.displayName
        userDisplayEmail.text = user.email
    }
    
    func saveProfile(){
        if let user = FIRAuth.auth()?.currentUser {
            let changeRequest = user.profileChangeRequest()
            
            changeRequest.displayName = userDisplayName.text
            changeRequest.commitChanges { error in
                if let error = error {
                    AppDelegate.showAlertMsg(withViewController: self, message: error.localizedDescription)
                } else {
                    AppDelegate.showAlertMsg(withViewController: self, message: "Profile name was updated")
                    self.setUserDataToView(withFIRUser: user)
                }
            }
        }
    }
    
}

// MARK : TextField Delegate
extension settingsProfileViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userDisplayName.resignFirstResponder()
        userDisplayEmail.resignFirstResponder()
        
        return true
    }
    
}

// MARK : Change Profile Photo
extension settingsProfileViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController,
                                       didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imageView.contentMode = .scaleAspectFit //3
        imageView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
