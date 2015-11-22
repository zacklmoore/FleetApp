//
//  stop.swift
//  fleetPrototyping
//
//  Created by Emily Greinwald on 11/13/15.
//  Copyright © 2015 Austin Cary. All rights reserved.
//

import UIKit
import CoreLocation;

class stop: roadEvent {
    
    //different stop types can be checked when creating the stop and will be represented as different symbols
    var type : stopType?
    
    enum stopType {
       case food, scenic, bathroom, gas
    }
    
    init(typeOfStop : stopType?, location : CLLocationCoordinate2D){
        super.init( location: location)
        self.type = typeOfStop
    }

}
