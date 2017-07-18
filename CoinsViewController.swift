//
//  CoinsViewController.swift
//  Noticar
//
//  Created by Tanut.leel on 11/22/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CoinsViewController: UITableViewController {

    var payCoins : [String] = []
    var payRate : [String] = []
    var user_email = ""
    var user_coins = ""
    
    @IBOutlet weak var showCoins: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        if let user = FIRAuth.auth()?.currentUser {
            setUserDataToView(withFIRUser: user)
            readData()
            readCoins()
            showCoins.text = user_coins
            self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        }
    }
    
    func refresh(sender:AnyObject)
    {
        readCoins()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    private func prepareNavigationItem() {
        navigationItem.title = "Charge"
    }
    
    func setUserDataToView(withFIRUser user: FIRUser) {
        user_email = user.email!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payCoins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CoinsCell
        cell.showCoins.text = payCoins[indexPath.row]
        cell.currency.text = payRate[indexPath.row]
        return cell
        
    }

}

//ReadCoins
extension CoinsViewController {
    
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

//Create ReadData
extension CoinsViewController {
    
    func readData(){
        
        let urlPath = "http://noticar.2th.info/coins.php"
        let jsonURL : URL = URL(string: urlPath)!
        let request = NSMutableURLRequest(url: jsonURL)
        
        let response:AutoreleasingUnsafeMutablePointer<URLResponse?>?=nil
        
        do{
            let jsonSource: Data = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: response)
            
            if let jsonObjects = (try? JSONSerialization.jsonObject(with: jsonSource, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSMutableArray{
                for dataDict : Any in jsonObjects  {
                    let place_Coins = (dataDict as AnyObject).object(forKey: "payCoins") as! NSString as String
                    let place_Rate = (dataDict as AnyObject).object(forKey: "payRatePay") as! NSString as String
                    payCoins.append(place_Coins)
                    payRate.append(place_Rate)
                }
            }
        }catch{
            print("Failed Connection..")
        }
        
    }
}
