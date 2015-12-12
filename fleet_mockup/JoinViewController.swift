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
    var foundTrip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
      foundTrip = joinTrip(tripIDField.text!)
        
        if(foundTrip != nil){
            trip = foundTrip;
            performSegueWithIdentifier("joinOverviewSegue", sender: self)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "No Trip was found with the given Trip ID.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil));
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}