//
//  ProfileViewController.swift
//  Noticar
//
//  Created by Tanut.leel on 11/18/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import Material
import FirebaseAuth

class ProfileViewController: UITableViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareTabBarItem()
    }
    
    @IBOutlet weak var displayName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareNavigationItem()
        
        // Firebase
        if let user = FIRAuth.auth()?.currentUser {
            setUserDataToView(withFIRUser: user)
        }
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
    }
    
    func refresh(sender:AnyObject)
    {
        // Firebase
        if let user = FIRAuth.auth()?.currentUser {
            setUserDataToView(withFIRUser: user)
        }
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func setUserDataToView(withFIRUser user: FIRUser) {
        displayName.text = user.displayName
    }
    
    private func prepareNavigationItem() {
        navigationItem.title = "Account"
    }

    func prepareTabBarItem() {
        tabBarItem.title = "Account"
        tabBarItem.image = #imageLiteral(resourceName: "ic_account_box").tint(with: Color.blueGrey.base)
        tabBarItem.selectedImage = #imageLiteral(resourceName: "ic_account_box").tint(with: Color.blue.base)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let target = segue.destination
        let selectedRowIndex = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: selectedRowIndex!)
        target.navigationItem.title = cell?.textLabel?.text
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
