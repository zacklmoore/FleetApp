//
//  TripSettingsViewController.swift
//  FleetApp
//
//  Created by Emily Greinwald on 11/22/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit

class TripSettingsViewController: UIViewController {
    
    @IBOutlet weak var tripNameField: UITextField!
    @IBOutlet weak var tripDateTimePicker: UIDatePicker!
    @IBOutlet weak var tripStartLocationField: UITextField!
    @IBOutlet weak var tripEndLocationField: UITextField!
    @IBOutlet weak var saveSettingsButton: UIButton!
    
    var delegate: settingsReturnDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(trip != nil)
        {
            tripNameField.text = trip!.name;
            tripDateTimePicker.date = trip!.startDateTime;
            tripStartLocationField.text = trip!.startString;
            tripEndLocationField.text = trip!.endString;
        }
        
        if(loggedInUser! != trip!.leader)
        {
            tripNameField.userInteractionEnabled = false;
            tripDateTimePicker.userInteractionEnabled = false;
            tripStartLocationField.userInteractionEnabled = false;
            tripEndLocationField.userInteractionEnabled = false;
            saveSettingsButton.hidden = true;
        }
        else
        {
            tripNameField.userInteractionEnabled = true;
            tripDateTimePicker.userInteractionEnabled = true;
            tripStartLocationField.userInteractionEnabled = true;
            tripEndLocationField.userInteractionEnabled = true;
            saveSettingsButton.hidden = false;
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        if(trip != nil)
        {
            tripNameField.text = trip!.name;
            tripDateTimePicker.date = trip!.startDateTime;
            tripStartLocationField.text = trip!.startString;
            tripEndLocationField.text = trip!.endString;
        }
        
        if(loggedInUser! != trip!.leader)
        {
            tripNameField.userInteractionEnabled = false;
            tripDateTimePicker.userInteractionEnabled = false;
            tripStartLocationField.userInteractionEnabled = false;
            tripEndLocationField.userInteractionEnabled = false;
            saveSettingsButton.hidden = true;
        }
        else
        {
            tripNameField.userInteractionEnabled = true;
            tripDateTimePicker.userInteractionEnabled = true;
            tripStartLocationField.userInteractionEnabled = true;
            tripEndLocationField.userInteractionEnabled = true;
            saveSettingsButton.hidden = false;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveTrip() {
        
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
            trip!.name = tripNameField.text!;
            trip!.startDateTime = tripDateTimePicker.date;
            trip!.startString = tripStartLocationField.text!;
            trip!.endString = tripEndLocationField.text!;
        
            navigationController?.popViewControllerAnimated(true);
        }
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        saveTrip();
    }
}