//
//  CarListViewController.swift
//  FleetApp
//
//  Created by Jake Shropshire on 11/18/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit

class CarListViewController: UIViewController, UITableViewDataSource {

    var objects : [String] = ["Jake's Car", "Austin's Car"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        //self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        //cell.textLabel?.text = objects[indexPath.row]
        let cell = UITableViewCell();
        cell.textLabel?.text = "Car"
        return cell
    }
    
}
