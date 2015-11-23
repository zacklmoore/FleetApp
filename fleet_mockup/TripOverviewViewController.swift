//
//  TripOverviewViewController.swift
//  FleetApp
//
//  Created by Emily Greinwald on 11/22/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit

class TripOverviewViewController: UIViewController {
    
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
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}