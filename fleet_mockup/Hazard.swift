//
//  hazard.swift
//  fleetPrototyping
//
//  Created by Emily Greinwald on 11/13/15.
//  Copyright © 2015 Austin Cary. All rights reserved.
//

import UIKit
import CoreLocation;

class hazard: roadEvent {

    var type : hazardType?
    
    enum hazardType{
        case carCrash, traffic, cop, roadKill
    }
    
    init(typeOfHazard: hazardType?, location : CLLocationCoordinate2D){
        super.init(location: location)
        self.type = typeOfHazard
    }
}
