//
//  CoinsMainViewController.swift
//  Noticar
//
//  Created by Tanut.leel on 11/23/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CoinsMainViewController : UITableViewController {
    
    @IBOutlet weak var showCoins: UILabel!
    
    var user_email = ""
    var user_coins = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = FIRAuth.auth()?.currentUser {
            setUserDataToView(withFIRUser: user)
            readCoins()
            showCoins.text = user_coins
            self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        }
        
    }
    
    func setUserDataToView(withFIRUser user: FIRUser) {
        user_email = user.email!
    }
    
    func refresh(sender:AnyObject)
    {
        readCoins()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
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
