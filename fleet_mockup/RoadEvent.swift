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
    var titleString: String
    var subtitleString: String
    var eventType : EventType
    
    enum EventType : Int {
        case Stop, Hazard
    }
    
    init(loc : CLLocationCoordinate2D, event: EventType, title: String, subtitle: String){
        self.location = loc
        self.eventType = event
        self.titleString = title
        self.subtitleString = subtitle
    }

    func cancelRoadEvent(){
        
    }
}
