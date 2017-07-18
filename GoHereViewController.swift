//
//  GoHereViewController.swift
//  Noticar
//
//  Created by Tanut.leel on 11/21/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Material

class GoHereViewController : UITableViewController {
    
    var place_name : String = ""
    var place_limit : String = ""
    var place_coins : String = ""
    var user_email : String = ""
    var user_coins : String = ""
    var time : String = ""
    
    @IBOutlet weak var lbHour: UILabel!
    @IBOutlet weak var lbCoins: UILabel!
    @IBOutlet weak var lbShowCoins: UILabel!
    
    @IBAction func getNotifications(_ sender: Any) {
        createLocalNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = FIRAuth.auth()?.currentUser {
            setUserDataToView(withFIRUser: user)
        }
        
        readData()
        readCoins()
        
        lbHour.text = place_limit
        lbCoins.text = place_coins
        lbShowCoins.text = user_coins
        
    }
    
    func setUserDataToView(withFIRUser user: FIRUser) {
        user_email = user.email!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//Create ReadData
extension GoHereViewController {
    
    func readData(){
        
        let urlPath = "http://noticar.2th.info/places.php"
        let jsonURL : URL = URL(string: urlPath)!
        let request = NSMutableURLRequest(url: jsonURL)
        request.httpMethod = "POST"
        let checkString = "navtitle=\(navigationItem.title!)"
        request.httpBody = checkString.data(using: String.Encoding.utf8)
        
        let response:AutoreleasingUnsafeMutablePointer<URLResponse?>?=nil
        
        do{
            let jsonSource: Data = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: response)
            
            if let jsonObjects = (try? JSONSerialization.jsonObject(with: jsonSource, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSMutableArray{
                for dataDict : Any in jsonObjects  {
                    let p_limit = (dataDict as AnyObject).object(forKey: "place_limit") as! NSString as String
                    let p_coins = (dataDict as AnyObject).object(forKey: "place_coins") as! NSString as String
                    place_limit.append(p_limit)
                    place_coins.append(p_coins)
                }
            }
        }catch{
            print("Failed Connection..")
        }
        
    }
}

extension GoHereViewController{
    
    func readCoins(){
        let urlPath = "http://noticar.2th.info/users.php"
        let jsonURL : URL = URL(string: urlPath)!
        let request = NSMutableURLRequest(url: jsonURL)
        request.httpMethod = "POST"
        let checkString = "email=\(user_email)"
        request.httpBody = checkString.data(using: String.Encoding.utf8)
        
        let response:AutoreleasingUnsafeMutablePointer<URLResponse?>?=nil
        
        do{
            let jsonSource: Data = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: response)
            
            if let jsonObjects = (try? JSONSerialization.jsonObject(with: jsonSource, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSMutableArray{
                for dataDict : Any in jsonObjects  {
                    let u_coins = (dataDict as AnyObject).object(forKey: "u_coins") as! NSString as String
                    user_coins.append(u_coins)
                }
            }
        }catch{
            print("Failed Connection..")
        }
        
    }
    
}

// Create Notification
extension GoHereViewController{
    
    func createLocalNotification()
    {
        let localNotification = UILocalNotification()
        localNotification.fireDate = Date(timeIntervalSinceNow: 10) // Set 10 seconds Test Action
        localNotification.soundName = UILocalNotificationDefaultSoundName
        
        localNotification.userInfo = ["message" : "You can also activities this further 30 minutes."]
        
        localNotification.alertBody = "You can also activities this further 30 minutes."
        
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    func application(_ application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        if application.applicationState == .active {
            
        }
        self.takeActionWithNotification(notification)
    }
    
    func takeActionWithNotification(_ localNotification: UILocalNotification)
    {
        let notificationMessage = localNotification.userInfo!["message"] as! String
        let alertController = UIAlertController(title: "Notifications close to the time limit.", message: notificationMessage, preferredStyle: .alert)
        let remindMeLaterAction = UIAlertAction(title: "Remind Me Late", style: .default, handler: nil)
        let closeAction = UIAlertAction(title: "Close", style: .default) {
            (action) -> Void in self.view
        }
        
        alertController.addAction(remindMeLaterAction)
        alertController.addAction(closeAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
