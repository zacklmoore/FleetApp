//
//  trip.swift
//  fleetPrototyping
//
//  Created by Emily Greinwald on 11/13/15.
//  Copyright © 2015 Austin Cary. All rights reserved.
//

import UIKit
import CoreLocation;

class Trip: NSObject {
    var startString: String
    var endString: String
    var startLoc: CLLocationCoordinate2D
    var endLoc: CLLocationCoordinate2D
    var id : String
    var name : String
    var startDateTime: NSDate
    var leader : User
    var members = [User]()
    var vehicles = [Vehicle]()
    var roadEvents = [RoadEvent]()
    var totalMiles : Int = 0
    var defaultColors = [UIColor]()
    var usedColors = [UIColor]()
    
    //for larger trips more colors might be necessary
    var numColors : Int = 20
    
    init(name: String, lead: User, dateTime: NSDate, startPoint : CLLocationCoordinate2D, endPoint: CLLocationCoordinate2D, startName: String, endName: String) {
        
        self.name = name;
        self.leader = lead;
        self.endString = startName;
        self.startString = endName;
        self.startLoc = startPoint;
        self.endLoc = endPoint;
        self.startDateTime = dateTime;
        self.id = ""
        
        //Eventually add creator's user to init once we have users working
        
        for _ in 1...20 {
            defaultColors.append(UIColor.randomFlatColor())
        }
    }
    
    func vehicleForUser(user: User) -> Vehicle? {
        for v in vehicles {
            if(v.passengers.contains(user))
            {
                return v;
            }
        }
        
        return nil;
    }
    
    /* Temporarily Commented Out Until All Pre-Requisites Implemented
    func addVehicle(vColor: UIColor, vOwner: user, defaultColors: [UIColor], usedColors: [UIColor]) -> (UIColor){
        let newVehicle = Vehicle(vColor: vColor, vOwner: vOwner, usedColors: usedColors, defaultColors: defaultColors)
        vehicles.append(newVehicle)
       return newVehicle.textColor
    }*/
    
}
