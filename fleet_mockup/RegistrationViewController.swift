//
//  RegistrationViewController.swift
//  FleetApp
//
//  Created by Zackary Moore on 12/3/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    var delegate: registerReturnDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func createUser() {
        //Validate form data
        if(usernameField.text == "" || passwordField.text == "" ||
            firstNameField.text == "" || lastNameField.text == "")
        {
            let alert = UIAlertController(title: "Error", message: "One or more fields is blank.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil));
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            if(uniqueUsername(usernameField.text!.lowercaseString))
            {
                let newUser = User(uName: usernameField.text!.lowercaseString, pWord: passwordField.text!, fName: firstNameField.text!, lName: lastNameField.text!);
                delegate.registerUser(newUser);
                navigationController?.popViewControllerAnimated(true);
            }
            else
            {
                let alert = UIAlertController(title: "Error", message: "This username is already taken.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil));
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    func uniqueUsername(string: String) -> Bool {
        for u in userList {
            if(u.username == string)
            {
                return false;
            }
        }
        return true;
    }
    
    @IBAction func finishButtonPressed(sender: AnyObject) {
        createUser()
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
}
