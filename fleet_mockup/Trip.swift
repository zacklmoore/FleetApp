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
    //var endPoint : CLLocationCoordinate2D
    //var startPoint : CLLocationCoordinate2D
    //Temporary until we get lcoation selection working
    var startString: String
    var endString: String
    //-------------------------------------------------
    var name : String
    var startDateTime: NSDate
    var members = [user]()
    var vehicles = [Vehicle]()
    var roadEvents = [RoadEvent]()
    var totalMiles : Int = 0
    var defaultColors = [UIColor]()
    var usedColors = [UIColor]()
    
    //for larger trips more colors might be necessary
    var numColors : Int = 20
    
    init(name: String, dateTime: NSDate, startPoint : String, endPoint: String) {
        
        self.name = name;
        self.endString = endPoint;
        self.startString = startPoint;
        self.startDateTime = dateTime;
        
        //Eventually add creator's user to init once we have users working
        
        
        //Temporary until we get lcoation selection working
        self.startString = ""
        self.endString = ""
        //-------------------------------------------------
        
        for _ in 1...20 {
            defaultColors.append(UIColor.randomFlatColor())
        }
    }
    
    func addVehicle(vColor: UIColor, vOwner: user, defaultColors: [UIColor], usedColors: [UIColor]) -> (UIColor){
        let newVehicle = Vehicle(vColor: vColor, vOwner: vOwner, usedColors: usedColors, defaultColors: defaultColors)
        vehicles.append(newVehicle)
       return newVehicle.textColor
    }
    
}
