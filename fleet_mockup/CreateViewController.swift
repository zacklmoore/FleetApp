//
//  CreateViewController.swift
//  FleetApp
//
//  Created by Emily Greinwald on 11/22/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    @IBOutlet weak var tripNameField: UITextField!
    @IBOutlet weak var tripDateTimePicker: UIDatePicker!
    @IBOutlet weak var tripStartLocationField: UITextField!
    @IBOutlet weak var tripEndLocationField: UITextField!
    
    var newTrip: Trip!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            newTrip = Trip(name: tripNameField.text!, dateTime: tripDateTimePicker.date, startPoint: tripStartLocationField.text!, endPoint: tripEndLocationField.text!);
            newTrip.vehicles.append(Vehicle(owner: "myUsername"));
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
    }
    
    @IBAction func createTripButtonPressed(sender: AnyObject) {
        createTrip();
    }
}
