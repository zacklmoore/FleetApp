//
//  CreateViewController.swift
//  FleetApp
//
//  Created by Emily Greinwald on 11/22/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit
import CoreLocation

//Protocols to enable delegation for Location Select data passback
protocol startLocationReturnDelegate {
    func saveStartLocation(loc: CLLocationCoordinate2D);
}

protocol endLocationReturnDelegate {
    func saveEndLocation(loc: CLLocationCoordinate2D);
}

class CreateViewController: UIViewController, startLocationReturnDelegate, endLocationReturnDelegate {
    
    @IBOutlet weak var tripNameField: UITextField!
    @IBOutlet weak var tripDateTimePicker: UIDatePicker!
    @IBOutlet weak var tripStartLocationField: UITextField!
    @IBOutlet weak var tripEndLocationField: UITextField!
    
    var newTrip: Trip!
    var startLoc: CLLocationCoordinate2D?
    var endLoc: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tripStartLocationField.enabled = false;
        tripEndLocationField.enabled = false;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTrip() {
        //Validate form data
        if(tripNameField.text == "" || tripStartLocationField.text == "" ||
            tripEndLocationField.text == "")
        {
            let alert = UIAlertController(title: "Error", message: "One or more fields is blank.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil));
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            //Create Trip object
            newTrip = Trip(name: tripNameField.text!, lead: loggedInUser!, dateTime: tripDateTimePicker.date, startPoint: startLoc!, endPoint: endLoc!, startName: tripStartLocationField.text!, endName: tripEndLocationField.text!);
            trips.append(newTrip)
            newTrip.vehicles.append(Vehicle(vCap: loggedInUser!));
            performSegueWithIdentifier("createOverviewSegue", sender: self);
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "createOverviewSegue")
        {
            let nextNav = segue.destinationViewController  as! UINavigationController;
            let next = nextNav.topViewController as! TripOverviewViewController;
            
            next.trip = newTrip;
        }
        else if(segue.identifier == "selectStartLocationSegue")
        {
            let next = segue.destinationViewController as! LocationSelectViewController;
            next.startDelegate = self;
            
        }
        else if(segue.identifier == "selectEndLocationSegue")
        {
            let next = segue.destinationViewController as! LocationSelectViewController;
            next.endDelegate = self;
        }
    }
    
    func saveStartLocation(loc: CLLocationCoordinate2D) {
        startLoc = loc;
        tripStartLocationField.enabled = true;
        tripStartLocationField.placeholder = "Name this Location...";
    }
    
    func saveEndLocation(loc: CLLocationCoordinate2D) {
        endLoc = loc;
        tripEndLocationField.enabled = true;
        tripEndLocationField.placeholder = "Name this Location...";
    }
    
    @IBAction func createTripButtonPressed(sender: AnyObject) {
        createTrip();
    }
    
}
