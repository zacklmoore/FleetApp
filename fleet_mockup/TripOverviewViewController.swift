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

class TripOverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, settingsReturnDelegate {
    
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var tripIDLabel: UILabel!
    @IBOutlet weak var tripLocationsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
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
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "carCell");
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
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
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip!.vehicles.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CarTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("CarTableViewCell") as! CarTableViewCell;
        
        cell.carNameLabel.text = trip!.vehicles[indexPath.row].vOwnerName + "'s Car";
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
        let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to leave this trip?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler:
            {
                action in self.leaveTrip();
        }));
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil));
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func addCarButtonPressed(sender: AnyObject) {
        
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