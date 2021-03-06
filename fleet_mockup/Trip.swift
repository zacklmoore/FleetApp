//
//  trip.swift
//  fleetPrototyping
//
//  Created by Emily Greinwald on 11/13/15.
//  Copyright © 2015 Austin Cary. All rights reserved.
//

import UIKit
import CoreLocation
import JSQMessagesViewController

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
    var messages = [JSQMessage]()
    var totalMiles : Int = 0
    var defaultColors = [UIColor]()
    var usedColors = [UIColor]()
    
    //for larger trips more colors might be necessary
    var numColors : Int = 20
    
    init(name: String, lead: User, dateTime: NSDate, startPoint : CLLocationCoordinate2D, endPoint: CLLocationCoordinate2D, startName: String, endName: String) {
        
        self.name = name;
        self.leader = lead;
        self.startString = startName;
        self.endString = endName;
        self.startLoc = startPoint;
        self.endLoc = endPoint;
        self.startDateTime = dateTime;
        
        self.id = self.leader.username + "_" + NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle);
        
        self.id = self.id.stringByReplacingOccurrencesOfString(", ", withString: "");
        self.id = self.id.stringByReplacingOccurrencesOfString("\\", withString: "");
        self.id = self.id.stringByReplacingOccurrencesOfString("/", withString: "");
        self.id = self.id.stringByReplacingOccurrencesOfString(":", withString: "");
        self.id = self.id.stringByReplacingOccurrencesOfString(" AM", withString: "");
        self.id = self.id.stringByReplacingOccurrencesOfString(" PM", withString: "");
        
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
    
    func eventForCoordinate(coord: CLLocationCoordinate2D) -> RoadEvent? {
        for e in roadEvents {
            if(e.location.latitude == coord.latitude && e.location.longitude == coord.longitude)
            {
                return e;
            }
        }
        return nil;
    }
    
    func userForUsername(name: String) ->User? {
        for v in vehicles {
            for u in v.passengers {
                if(u.username == name)
                {
                    return u;
                }
            }
        }
        return nil;
    }
}
