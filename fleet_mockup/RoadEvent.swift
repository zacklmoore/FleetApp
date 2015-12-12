//
//  roadEvent.swift
//  fleetPrototyping
//
//  Created by Emily Greinwald on 11/13/15.
//  Copyright © 2015 Austin Cary. All rights reserved.
//

import UIKit
import CoreLocation;

class RoadEvent: NSObject {
    
    var location : CLLocationCoordinate2D
    var descString: String
    var creator: User
    var eventType : EventType
    
    enum EventType : Int {
        case Stop, Hazard, Food, Gas, Crash, Traffic, Cop, Other
    }
    
    init(loc : CLLocationCoordinate2D, create: User, event: EventType, desc: String){
        self.location = loc
        self.eventType = event
        self.descString = desc
        self.creator = create
    }

    func cancelRoadEvent(){
        
    }
}
