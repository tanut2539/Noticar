//
//  MapsViewController.swift
//  Noticar
//
//  Created by Tanut.leel on 11/17/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Material

class MapsViewController : UIViewController, UICollectionViewDelegateFlowLayout ,GMSMapViewDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareTabBarItem()
    }
    
    var placeTitle : [String] = []
    var placeDetail : [String] = []
    var placeStatus : [String] = []
    var placeImg : [String] = []
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var MapsView: GMSMapView!
    @IBOutlet weak var showPlaces: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareNavigationItem()
        
        // MARK: - LoadData
        readData()
        
        // MARK: - Start Maps Delegate
        self.MapsView.isMyLocationEnabled = true
        self.MapsView.settings.compassButton = true
        self.MapsView.settings.myLocationButton = true
        self.MapsView.delegate = self
        
        // MARK: - Location Manager
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = 150.0
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
        // ShowPlaces Delegate
        showPlaces.dataSource = self
        showPlaces.delegate = self
        
    }
    
    private func prepareTabBarItem() {
        tabBarItem.title = "Near by"
        tabBarItem.image = #imageLiteral(resourceName: "ic_near_me").tint(with: Color.blueGrey.base)
        tabBarItem.selectedImage = #imageLiteral(resourceName: "ic_near_me").tint(with: Color.blue.base)
    }
    
    private func prepareNavigationItem() {
        navigationItem.title = "Near by"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//Create LocationManager
extension MapsViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let camera = GMSCameraPosition(target: location.coordinate, zoom: 17, bearing: 0, viewingAngle: 0)
            MapsView.animate(to: camera)
            locationManager.stopUpdatingLocation()
        }
    }
    
}

//Create ReadData
extension MapsViewController {
    
    func readData(){
        
        let urlPath = "http://noticar.2th.info/data.php"
        let jsonURL : URL = URL(string: urlPath)!
        let request = NSMutableURLRequest(url: jsonURL)
        
        let response:AutoreleasingUnsafeMutablePointer<URLResponse?>?=nil
        
        do{
            let jsonSource: Data = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: response)
            
            if let jsonObjects = (try? JSONSerialization.jsonObject(with: jsonSource, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSMutableArray{
                for dataDict : Any in jsonObjects  {
                    let placeName = (dataDict as AnyObject).object(forKey: "place_name") as! NSString as String
                    let placePosition = (dataDict as AnyObject).object(forKey: "place_position") as! NSString as String
                    let placeImage = (dataDict as AnyObject).object(forKey: "place_image") as! NSString as String
                    placeTitle.append(placeName)
                    placeDetail.append(placePosition)
                    placeImg.append(placeImage)
                }
            }
        }catch{
            print("Failed Connection..")
        }
        
    }
}
