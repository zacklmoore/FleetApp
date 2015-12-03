//
//  vehicle.swift
//  fleetPrototyping
//
//  Created by Emily Greinwald on 11/13/15.
//  Copyright © 2015 Austin Cary. All rights reserved.
//

import UIKit


class Vehicle: NSObject {
    
// This object has lots of optionals that the user could choose to input. The make, model, and color of the vehicle could be useful for vehicle identification in cases when people are being picked up. The MPG could be used to calculate gas money to split the cost of the trip.
    
   
    var make : String?
    var model : String?
    var vOwnerName: String
    var vehicleColor : UIColor?
    var MPG : Int?
    var people = [user]()
    
    //textColor = vehicleColor except when vehicleColor has already been used for a vehicle on this trip.
    var textColor : UIColor?
    
    // add ~20 default color values
    // remove all the colors in the usedColors array in the init before initializing textColor
    
    //Temporary init
    init(owner: String)
    {
        vOwnerName = owner
    }
    
    //Temprarily disabled until all pre-requistes implemented
    /*
    init(vColor : UIColor, vOwner : user, usedColors : [UIColor], var defaultColors : [UIColor]) {
        self.vehicleColor = vColor
        People.append(vOwner)
        
        //add colors to default colors
        
        
        if !usedColors.contains(vColor){
            textColor = vColor
        }
        else{
           textColor = defaultColors.popLast()!
        }
        
    }
    */
    
    
}
