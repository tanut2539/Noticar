//
//  PlacesViewController.swift
//  Noticar
//
//  Created by TOEY on 11/1/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import GoogleMaps
import Material

class PlacesViewController: UITableViewController {
    
    @IBOutlet weak var MapDetail: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        placePick()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsViewController = segue.destination
        detailsViewController.navigationItem.title = navigationItem.title
        detailsViewController.navigationItem.detail = navigationItem.detail
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// Create Pickup Location
extension PlacesViewController {
    
    func placePick(){
        
        let marker = GMSMarker()
        var camera = GMSCameraPosition()
        
        if(navigationItem.title == "Tesco Lotus"){
            marker.position = CLLocationCoordinate2DMake(13.993458, 100.6137018)
            camera = GMSCameraPosition.camera(withLatitude: 13.993458, longitude: 100.6137018 ,zoom: 16.5)
        }
        else if(navigationItem.title == "Index Living mall"){
            marker.position = CLLocationCoordinate2DMake(13.9920928, 100.6181678)
            camera = GMSCameraPosition.camera(withLatitude: 13.9920928, longitude: 100.6181678 ,zoom: 16.5)
        }
        else if(navigationItem.title == "Future Park Rangsit"){
            marker.position = CLLocationCoordinate2DMake(13.9888308, 100.6173046)
            camera = GMSCameraPosition.camera(withLatitude: 13.9888308, longitude: 100.6173046 ,zoom: 16)
        }
        else if(navigationItem.title == "Major Ciniplex Rangsit"){
            marker.position = CLLocationCoordinate2DMake(13.9871777, 100.6164957)
            camera = GMSCameraPosition.camera(withLatitude: 13.9871777, longitude: 100.6164957 ,zoom: 16.5)
        }
        else if(navigationItem.title == "Zeer Rangsit"){
            marker.position = CLLocationCoordinate2DMake(13.9613211, 100.6232095)
            camera = GMSCameraPosition.camera(withLatitude: 13.9613211, longitude: 100.6232095 ,zoom: 16.5)
        }
        else if(navigationItem.title == "Siam Makro Khlongluang"){
            marker.position = CLLocationCoordinate2DMake(14.066627, 100.6330022)
            camera = GMSCameraPosition.camera(withLatitude: 14.066627, longitude: 100.6330022 ,zoom: 16.5)
        }
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.icon = UIImage(named: "flag_icon")
        marker.map = MapDetail
        
        MapDetail!.animate(to: camera)
    }
    
}
