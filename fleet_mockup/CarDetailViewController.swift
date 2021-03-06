//
//  CarDetailViewController.swift
//  FleetApp
//
//  Created by Zackary Moore on 12/3/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit

class CarDetailViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, SwiftColorPickerDelegate {
    
    @IBOutlet weak var carMakeLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var carColorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var joinLeaveButton: UIButton!
    @IBOutlet weak var makeText: UITextField!
    @IBOutlet weak var modelText: UITextField!
    @IBOutlet weak var colorText: UITextField!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var selectColorButton: UIButton!
    @IBOutlet weak var carIcon: UIImageView!
    
    @IBAction func saveButton(sender: AnyObject) {
        vehicle.make = makeText.text
        vehicle.model = modelText.text
        vehicle.color = colorText.text
    }
    
    var vehicle: Vehicle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        carNameLabel.text = vehicle.captain.firstName + " " + vehicle.captain.lastName + "'s Car";

        if(loggedInUser?.username != vehicle.captain.username){
            makeText.userInteractionEnabled = false
            modelText.userInteractionEnabled = false
            colorText.userInteractionEnabled = false
            save.hidden = true
            selectColorButton.hidden = true
            
        }
        else{
            makeText.userInteractionEnabled = true
            modelText.userInteractionEnabled = true
            colorText.userInteractionEnabled = true
            save.hidden = false
            selectColorButton.hidden = false
            
        }
        
        makeText.text = vehicle.make
        modelText.text = vehicle.model
        colorText.text = vehicle.color
        carIcon.image = carIcon.image!.imageWithRenderingMode(.AlwaysTemplate);
        carIcon.tintColor = vehicle.textColor;
        
        if(vehicle.captain == loggedInUser!)
        {
            joinLeaveButton.setTitle("Remove your Car", forState: .Normal);
        }
        else if(vehicle.passengers.contains(loggedInUser!))
        {
            joinLeaveButton.setTitle("Leave this Car", forState: .Normal);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(vehicle != nil)
        {
            return vehicle.passengers.count;
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:PassengerTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("PassengerTableViewCell") as! PassengerTableViewCell;
        
        cell.nameLabel.text = vehicle.passengers[indexPath.row].firstName + " " + vehicle.passengers[indexPath.row].lastName;
        
        return cell
    }
    
    func colorSelectionChanged(selectedColor color: UIColor) {
        carIcon.tintColor = color;
        vehicle.textColor = color;
    }
    
    // MARK: popover presenation delegates
    
    // this enables pop over on iphones
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.None
    }
    
    @IBAction func joinButtonPressed(sender: AnyObject) {
        let uVehicle = trip!.vehicleForUser(loggedInUser!);
        
        if(vehicle.captain == loggedInUser!)
        {
            trip!.vehicles.removeAtIndex(trip!.vehicles.indexOf(vehicle!)!);
            navigationController?.popViewControllerAnimated(true);
        }
        else if(uVehicle == nil)
        {
            vehicle.passengers.append(loggedInUser!);
            joinLeaveButton.setTitle("Leave this Car", forState: .Normal);
        }
        else if(uVehicle == vehicle)
        {
            vehicle.passengers.removeAtIndex(vehicle.passengers.indexOf(loggedInUser!)!);
            joinLeaveButton.setTitle("Join this Car", forState: .Normal);
        }
        else if(uVehicle!.captain == loggedInUser!)
        {
            let alert = UIAlertController(title: "Error", message: "You are already the Captain of another Car.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil));
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            uVehicle!.passengers.removeAtIndex(uVehicle!.passengers.indexOf(loggedInUser!)!);
            vehicle.passengers.append(loggedInUser!);
            joinLeaveButton.setTitle("Leave this Car", forState: .Normal);
        }
        
        self.tableView.reloadData();
    }
    
    @IBAction func selectColorButtonPressed(sender: AnyObject) {
        let colorPickerVC = SwiftColorPickerViewController()
        colorPickerVC.delegate = self
        colorPickerVC.modalPresentationStyle = .Popover
        let popVC = colorPickerVC.popoverPresentationController!;
        popVC.sourceRect = sender.frame
        popVC.sourceView = self.view
        popVC.permittedArrowDirections = .Any;
        popVC.delegate = self;
        
        self.presentViewController(colorPickerVC, animated: true, completion: {
            print("Reade<");
        })
    }
    
}
