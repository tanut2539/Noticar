//
//  WebViewController.swift
//  Noticar
//
//  Created by TOEY on 11/1/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import  Material

class WebViewController: UIViewController {
    
    var LinkURL = ""
    var url = NSURL()
    var request = NSURLRequest()

    private var moreButton: IconButton!
    
    @IBOutlet weak var WebView : UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        webURL()
        
        prepareMoreButton()
        prepareNavigationItem()
        
    }
    
    private func prepareMoreButton() {
        moreButton = IconButton(image: Icon.cm.moreHorizontal)
    }
    
    private func prepareNavigationItem() {
        let moreButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_more_horiz"), style: .plain, target: self, action: #selector(alertAction))
        navigationItem.rightBarButtonItem = moreButton
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        self.hidesBottomBarWhenPushed = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension WebViewController : UIWebViewDelegate {
    
    func webURL(){
        if(navigationItem.title == "Terms of use"){
            url = NSURL(string: "http://noticar.2th.info/terms-of-use")!
        }
        else if(navigationItem.title  == "Privacy"){
            url = NSURL(string: "http://noticar.2th.info/privacy")!
        }
        else if(navigationItem.title == "Facebook"){
            url = NSURL(string: "https://www.facebook.com/noticar")!
        }
            request = NSURLRequest(url: url as URL)
            WebView.loadRequest(request as URLRequest)
            WebView.delegate = self
    }
    
    func alertAction(){
        if(navigationItem.title == "Terms of use"){
            let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let OpenSafari = UIAlertAction(title: "Open Safari", style: .default)
            {(alert: UIAlertAction!) -> Void in if let url = NSURL(string: "http://noticar.2th.info/terms-of-use"){
                UIApplication.shared.openURL(url as URL)
                }}
            let Cancel = UIAlertAction(title: "Cancel", style: .cancel)
            {(alert: UIAlertAction!) -> Void in self.view}
            optionMenu.addAction(OpenSafari)
            optionMenu.addAction(Cancel)
            present(optionMenu, animated: true, completion: nil)
        }
        else if(navigationItem.title == "Privacy"){
            let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let OpenSafari = UIAlertAction(title: "Open Safari", style: .default)
            {(alert: UIAlertAction!) -> Void in if let url = NSURL(string: "http://noticar.2th.info/privacy"){
                UIApplication.shared.openURL(url as URL)
                }}
            let Cancel = UIAlertAction(title: "Cancel", style: .cancel)
            {(alert: UIAlertAction!) -> Void in self.view}
            optionMenu.addAction(OpenSafari)
            optionMenu.addAction(Cancel)
            present(optionMenu, animated: true, completion: nil)
        }
        else if(navigationItem.title == "Facebook"){
            let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let OpenSafari = UIAlertAction(title: "Open Safari", style: .default)
            {(alert: UIAlertAction!) -> Void in if let url = NSURL(string: "https://www.facebook.com/noticar"){
                UIApplication.shared.openURL(url as URL)
                }}
            let Cancel = UIAlertAction(title: "Cancel", style: .cancel)
            {(alert: UIAlertAction!) -> Void in self.view}
            optionMenu.addAction(OpenSafari)
            optionMenu.addAction(Cancel)
            present(optionMenu, animated: true, completion: nil)
        }
    }
    
}
