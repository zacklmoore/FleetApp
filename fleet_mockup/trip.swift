//
//  trip.swift
//  fleetPrototyping
//
//  Created by Emily Greinwald on 11/13/15.
//  Copyright © 2015 Austin Cary. All rights reserved.
//

import UIKit
import CoreLocation;

class trip: NSObject {
    var destination : CLLocationCoordinate2D
    var startPoint : CLLocationCoordinate2D
    var members = [user]()
    var vehicles = [vehicle]()
    var roadEvents = [roadEvent]()
    var totalMiles : Int = 0
    var defaultColors = [UIColor]()
    var usedColors = [UIColor]()
    
    //for larger trips more colors might be necessary
    var numColors : Int = 20
    
    init(destination: CLLocationCoordinate2D, startPoint : CLLocationCoordinate2D, tripCreator : user, creatorsVehicle : vehicle) {
   
        self.destination = destination
        self.startPoint = startPoint
        self.members.append(tripCreator)
        self.vehicles.append(creatorsVehicle)
        
        for _ in 1...20 {
        defaultColors.append(UIColor.randomFlatColor())
        }
    }
    
    func addVehicle(vColor: UIColor, vOwner: user, defaultColors: [UIColor], usedColors: [UIColor]) -> (UIColor){
        let newVehicle = vehicle(vColor: vColor, vOwner: vOwner, usedColors: usedColors, defaultColors: defaultColors)
        vehicles.append(newVehicle)
       return newVehicle.textColor
    }
    
}
