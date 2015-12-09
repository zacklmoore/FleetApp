//
//  CreateRoadEventViewController.swift
//  FleetApp
//
//  Created by Zackary Moore on 12/8/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit
import CoreLocation

class CreateRoadEventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var eventTypePicker: UIPickerView!
    @IBOutlet weak var eventTitleField: UITextField!
    @IBOutlet weak var eventSubtitleField: UITextField!
    
    var delegate: CreateRoadEventDelegate?
    var coordinates: CLLocationCoordinate2D!
    var pickerData = ["Stop", "Hazard", "Food", "Gas", "Crash", "Traffic", "Cop", "Other"]
    var eventTypeIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTypeIndex = 0;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row];
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eventTypeIndex = row;
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        if(eventTitleField.text == "" || eventSubtitleField.text == "" || eventTypeIndex == nil)
        {
            let alert = UIAlertController(title: "Error", message: "One or more fields is blank.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil));
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            let newEvent = RoadEvent(loc:coordinates, event: RoadEvent.EventType(rawValue: eventTypeIndex!)!, title: eventTitleField.text!, subtitle: eventSubtitleField.text!);
            
            delegate?.saveRoadEvent(newEvent);
            
            navigationController?.popViewControllerAnimated(true);
        }
    }
}
