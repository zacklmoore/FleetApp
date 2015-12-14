//
//  ViewController.swift
//  fleet_mockup
//
//  Created by Westley Bonack on 11/6/15.
//  Copyright (c) 2015 Daniel Meyer. All rights reserved.
//

import UIKit

class CreateJoinViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loggedInUser!.locationManager.startUpdatingLocation();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        loggedInUser!.locationManager.startUpdatingLocation();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "logoutSegue")
        {
            loggedInUser!.locationManager.stopUpdatingLocation();
        }
    }
}

