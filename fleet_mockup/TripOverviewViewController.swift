//
//  TripOverviewViewController.swift
//  FleetApp
//
//  Created by Emily Greinwald on 11/22/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit

//Protocol to enable delegation for Settings View Controller data passback
protocol settingsReturnDelegate {
    func saveTripSettings(newTrip: Trip);
}

class TripOverviewViewController: UIViewController, settingsReturnDelegate {
    
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var tripIDLabel: UILabel!
    @IBOutlet weak var tripLocationsLabel: UILabel!
    
    var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(trip != nil)
        {
            tripNameLabel.text = trip!.name;
            tripLocationsLabel.text = trip!.startString + " --> " + trip!.endString;
            tripIDLabel.text = "Trip ID: " + trip!.id
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if(trip != nil)
        {
            tripNameLabel.text = trip!.name;
            tripLocationsLabel.text = trip!.startString + " --> " + trip!.endString;
            tripIDLabel.text = "Trip ID: " + trip!.id
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Delegate method called by Settings View Controller
    func saveTripSettings(newTrip: Trip)
    {
        trip = newTrip;
    }
    
    //Handle leaving a trip
    func leaveTrip()
    {
        performSegueWithIdentifier("leaveTripSegue", sender: self);
    }
    
    @IBAction func leaveButtonPressed(sender: AnyObject) {
        print("Here!");
        let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to leave this trip?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler:
            {
                action in self.leaveTrip();
        }));
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil));
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "settingsSegue")
        {
            let nextViewController = segue.destinationViewController as! TripSettingsViewController;
            nextViewController.trip = trip;
            nextViewController.delegate = self;
        }
    }
}