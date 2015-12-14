//
//  user.swift
//  fleetPrototyping
//
//  Created by Emily Greinwald on 11/13/15.
//  Copyright © 2015 Austin Cary. All rights reserved.
//

import UIKit
import CoreLocation;

class User: NSObject, CLLocationManagerDelegate {
    var username : String
    var firstName : String
    var lastName : String
    var password : String
    var homeLocation : CLLocationCoordinate2D?
    var curLocation : CLLocation?
    var locationManager : CLLocationManager
    
    init(uName: String, pWord: String, fName: String, lName: String){
        self.username = uName
        self.password = pWord
        self.firstName = fName
        self.lastName = lName
        locationManager = CLLocationManager();
        
        //After own vars set
        super.init();
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        //locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        curLocation = locations.last;
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        
    }
    
    
}
