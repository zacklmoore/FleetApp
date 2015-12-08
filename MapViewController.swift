//
//  MapViewController.swift
//  FleetApp
//
//  Created by Jake Shropshire on 11/20/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var trip: Trip!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            self.mapView.delegate = self;
            let uilgr = UILongPressGestureRecognizer(target: self, action: "addAnnotation:")
            uilgr.minimumPressDuration = 2.0
            self.mapView.addGestureRecognizer(uilgr);

            updateTripLocations();
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTripLocations() {
        for v in trip!.vehicles {
            let annotation = MKPointAnnotation();
            annotation.title = v.captain.firstName + " " + v.captain.lastName + "'s Car";
            annotation.coordinate = v.captain.curLocation!.coordinate;
            self.mapView.addAnnotation(annotation);
        }
    }
    
    func addAnnotation(gestureRecognizer:UIGestureRecognizer){
        let touchPoint = gestureRecognizer.locationInView(self.mapView)
        let newCoordinates = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinates
        self.mapView.addAnnotation(annotation)
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        //Add a hazard or other pin
        
    }
    
    @IBAction func refreshButtonPressed(sender: AnyObject) {
        //Refresh user locations and pins
        self.mapView.removeAnnotations(self.mapView.annotations);
        updateTripLocations();
        //updateTripLocations()
    }
}
