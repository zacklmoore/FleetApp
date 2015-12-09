//
//  LoginViewController.swift
//  FleetApp
//
//  Created by Jake Shropshire on 11/18/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit
import Riffle

protocol registerReturnDelegate {
    func registerUser(newUser: User);
}

//User Should Be Global
var loggedInUser: User?

//Temporary Global Array of Users until Excis Impleneted
var userList = [User]();

class LoginViewController: UIViewController, registerReturnDelegate {
    
    @IBOutlet weak var passworField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerUser(newUser: User) {
        //Save User
        userList.append(newUser);
    }
    
    func login() -> User? {
        if(usernameField.text == "" || passworField.text == "")
        {
            let alert = UIAlertController(title: "Error", message: "One or more fields is blank.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil));
            self.presentViewController(alert, animated: true, completion: nil)
            return nil;
        }
        else
        {
            //Handle Login Via Excis HERE
            
            //The following code is temporary for fake logins. Remove it once Excis implemented
            for u in userList {
                if(u.username == usernameField.text && u.password == passworField.text)
                {
                    return u;
                }
            }
        }
        
        //Remove once Excis code implemented
        return nil;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "registerSegue")
        {
            let next = segue.destinationViewController as! RegistrationViewController;
            next.delegate = self;
        }
    }
    
    @IBAction func loginPressed(sender: UIButton) {
        loggedInUser = login();
        
        if(loggedInUser != nil)
        {
            //Logged In Successfully So Go On
            performSegueWithIdentifier("loginSegue", sender: self);
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Unable to login. Please check your username, password, and network connectivity.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil));
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
