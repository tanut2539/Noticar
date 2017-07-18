//
//  SettingsViewController.swift
//  NotiCar
//
//  Created by Tanut on 11/10/59.
//  Copyright © พ.ศ. 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import Material
import FirebaseAuth

class SettingsViewController: UITableViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareTabBarItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        
    }
    
    @IBAction func notificationS(_ sender: Any) {
        UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
    }
    
    @IBAction func signOut(_ sender: Any) {
        
        try! FIRAuth.auth()!.signOut()
        let loginNav = self.storyboard?.instantiateViewController(withIdentifier: "signIn")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginNav
        
    }

    private func prepareNavigationItem() {
        navigationItem.title = "Settings"
    }
    
    private func prepareTabBarItem() {
        tabBarItem.title = "Settings"
        tabBarItem.image = #imageLiteral(resourceName: "ic_settings").tint(with: Color.blueGrey.base)
            //Icon.cm.settings?.tint(with: Color.blueGrey.base)
        tabBarItem.selectedImage = #imageLiteral(resourceName: "ic_settings").tint(with: Color.blue.base)
            //Icon.cm.settings?.tint(with: Color.blue.base)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let target = segue.destination
        let selectedRowIndex = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: selectedRowIndex!)
        target.navigationItem.title = cell?.textLabel?.text
    }

}
