//
//  JoinViewController.swift
//  FleetApp
//
//  Created by Emily Greinwald on 11/22/15.
//  Copyright © 2015 CS407. All rights reserved.
//
import UIKit

class JoinViewController: UIViewController {
    
    @IBOutlet weak var tripIDField: UITextField!
    var theTrip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "joinOverviewSegue")
        {
            let nextNav = segue.destinationViewController  as! UINavigationController;
            let next = nextNav.topViewController as! TripOverviewViewController;
            if(theTrip != nil){
                next.trip = theTrip
            }
            
            //NOTE: Eventually Pass Recieved Trip Object
        }
    }
    
    func joinTrip(tripID: String) -> Trip? {
        //var found = false;
        for v in trips{
            if(v.id == tripID){
                return v
            }
        }
        return nil
    }
    
    @IBAction func joinTripButtonPressed(sender: AnyObject) {
      theTrip = joinTrip(tripIDField.text!)
        
        if(theTrip != nil){
            performSegueWithIdentifier("joinOverviewSegue", sender: self)
        }
    }
}