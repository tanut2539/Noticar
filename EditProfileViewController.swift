//
//  EditProfileViewController.swift
//  Noticar
//
//  Created by Tanut.leel on 11/19/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class EditProfileViewController: UITableViewController{

    @IBOutlet weak var userDisplayName: UITextField!
    @IBOutlet weak var userDisplayEmail: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()

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
                    self.InsertData()
                    let mainView = self.storyboard?.instantiateViewController(withIdentifier: "MainView")
                    self.present(mainView!, animated: true, completion: nil)
                    self.setUserDataToView(withFIRUser: user)
                }
            }
        }
    }
    
    func InsertData(){
        var result = ""
        var coins = 0
        let urlPath = "http://noticar.2th.info/insert.php"
        let jsonURL : URL = URL(string: urlPath)!
        let request = NSMutableURLRequest(url: jsonURL)
        request.httpMethod = "POST"
        let postString = "user_email=\(userDisplayEmail.text!)&user_displayname=\(userDisplayName.text!)&user_coins=\(coins)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let response:AutoreleasingUnsafeMutablePointer<URLResponse?>?=nil
        
        do{
            
            let jsonSource: Data = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: response)
            
            if let jsonObjects = (try? JSONSerialization.jsonObject(with: jsonSource, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSMutableArray{
                for dataDict : Any in jsonObjects {
                    result = (dataDict as AnyObject).object(forKey: "result") as! NSString as String
                }
            }
        }catch{
            print("Failed Connection..")
        }
        
    }
    
}

// MARK : TextField Delegate
extension EditProfileViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userDisplayName.resignFirstResponder()
        userDisplayEmail.resignFirstResponder()
        
        return true
    }

}

// MARK : Change Profile Photo
extension EditProfileViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
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
