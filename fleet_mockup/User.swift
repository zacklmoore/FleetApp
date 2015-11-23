//
//  user.swift
//  fleetPrototyping
//
//  Created by Emily Greinwald on 11/13/15.
//  Copyright © 2015 Austin Cary. All rights reserved.
//

import UIKit
import CoreLocation;

class User: NSObject {
    var username : String
    var homeLocation : CLLocationCoordinate2D?
    var driver : Bool
    var vehicleCaptain : Bool
    var transport : Vehicle
    var friends = [user]()
    
    init(name : String, driver: Bool, vehicleCaptain : Bool, transport : Vehicle){
        self.username = name
        self.driver = driver
        self.vehicleCaptain = vehicleCaptain
        self.transport = transport
        
    }
}
