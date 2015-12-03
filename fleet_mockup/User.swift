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
    var firstName : String
    var lastName : String
    var password : String
    var homeLocation : CLLocationCoordinate2D?
    var driver : Bool?
    var vehicleCaptain : Bool?
    
    init(uName: String, pWord: String, fName: String, lName: String){
        self.username = uName
        self.password = pWord
        self.firstName = fName
        self.lastName = lName
    }
}
