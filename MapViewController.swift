//
//  MapViewController.swift
//  FleetApp
//
//  Created by Jake Shropshire on 11/20/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
    var color: UIColor!
}

class EventPointAnnotation: MKPointAnnotation {
    var imageName: String!
    var creator: User!
}

protocol CreateRoadEventDelegate {
    func saveRoadEvent(event: RoadEvent);
}

class MapViewController: UIViewController, MKMapViewDelegate, CreateRoadEventDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var newCoords: CLLocationCoordinate2D?
    var newAnnotation: MKPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView.delegate = self;
        self.newAnnotation = MKPointAnnotation();
        self.newAnnotation!.title = "Click the + button above to add an event here.";
        self.newAnnotation!.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0);
        
        //Create Long Press Gesture Recognizer to allow adding annotations
        let uilgr = UILongPressGestureRecognizer(target: self, action: "addAnnotation:")
        uilgr.minimumPressDuration = 1.25
        self.mapView.addGestureRecognizer(uilgr);
        
        //Load map pins
        updateTripLocations();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is CustomPointAnnotation) {
            let reuseId = "custom"
            
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            if anView == nil {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView!.canShowCallout = true
            }
            else {
                anView!.annotation = annotation
            }
            
            //Set annotation-specific properties **AFTER**
            //the view is dequeued or created...
            
            let cpa = annotation as! CustomPointAnnotation
            anView!.image = UIImage(named:cpa.imageName)
            anView!.layer.anchorPoint = CGPointMake(0.5, 1.0);
            
            if(cpa.color != nil)
            {
                anView!.image = anView!.image!.imageWithRenderingMode(.AlwaysTemplate).colorized(cpa.color);
            }
            
            return anView
        }
        else if (annotation is EventPointAnnotation) {
            let reuseId = "event"
            
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            if anView == nil {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView!.canShowCallout = true
            }
            else {
                anView!.annotation = annotation
            }
            
            //Set annotation-specific properties **AFTER**
            //the view is dequeued or created...
            
            let cpa = annotation as! EventPointAnnotation
            anView!.image = UIImage(named:cpa.imageName)
            anView!.layer.anchorPoint = CGPointMake(0.5, 1.0);
            
            if(cpa.creator == loggedInUser! || loggedInUser == trip!.leader)
            {
                let deleteButton = UIButton(type: UIButtonType.Custom)
                deleteButton.frame.size.width = 24
                deleteButton.frame.size.height = 24
                deleteButton.setImage(UIImage(named: "trash"), forState: .Normal)
                anView!.rightCalloutAccessoryView = deleteButton
            }
            
            return anView
        }
        
        return nil;
    }
    
    func updateTripLocations() {
        //Clear map of all annotations
        self.mapView.removeAnnotations(self.mapView.annotations);
        newCoords = nil;
        
        //Pins for Start / Finish
        let startAnnotation = CustomPointAnnotation();
        startAnnotation.title = trip!.startString;
        startAnnotation.coordinate = trip!.startLoc;
        startAnnotation.imageName = "startPointer";
        self.mapView.addAnnotation(startAnnotation);
        
        let endAnnotation = CustomPointAnnotation();
        endAnnotation.title = trip!.endString;
        endAnnotation.coordinate = trip!.endLoc;
        endAnnotation.imageName = "endPointer";
        self.mapView.addAnnotation(endAnnotation);
        
        //Pins for Vehicles
        for v in trip!.vehicles {
            let annotation = CustomPointAnnotation();
            annotation.title = v.captain.firstName + " " + v.captain.lastName + "'s Car";
            annotation.coordinate = v.captain.curLocation!.coordinate;
            
            if(trip!.vehicleForUser(loggedInUser!) == v)
            {
                annotation.imageName = "car-icon-flip";
                annotation.color = v.textColor;
            }
            else
            {
                annotation.imageName = "car-icon-flip";
                annotation.color = v.textColor;
            }
            self.mapView.addAnnotation(annotation);
        }
        
        //Pins for Road Events...
        for e in trip!.roadEvents
        {
            let annotation = EventPointAnnotation();
            annotation.title = e.creator.firstName + " " + e.creator.lastName;
            annotation.subtitle = e.descString;
            annotation.coordinate = e.location;
            annotation.creator = e.creator;
            
            //Set custom annotation icons
            
            switch(e.eventType)
            {
                case RoadEvent.EventType.Stop:
                    annotation.imageName = "stopPointer"
                    break;
                case RoadEvent.EventType.Hazard:
                    annotation.imageName = "hazardPointer"
                    break;
                case RoadEvent.EventType.Food:
                    annotation.imageName = "foodPointer"
                    break;
                case RoadEvent.EventType.Gas:
                    annotation.imageName = "gasPointer"
                    break;
                case RoadEvent.EventType.Crash:
                    annotation.imageName = "crashPointer"
                    break
                case RoadEvent.EventType.Traffic:
                    annotation.imageName = "trafficPointer"
                    break
                case RoadEvent.EventType.Cop:
                    annotation.imageName = "copPointer"
                    break
                case RoadEvent.EventType.Other:
                    annotation.imageName = "check_mark"
                    break
            }
            
            
            self.mapView.addAnnotation(annotation);
        }
    }
    
    func addAnnotation(gestureRecognizer:UIGestureRecognizer) {
        self.mapView.removeAnnotation(newAnnotation!);
        let touchPoint = gestureRecognizer.locationInView(self.mapView)
        let newCoordinates = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        newAnnotation!.coordinate = newCoordinates;
        newCoords = newCoordinates;
        self.mapView.addAnnotation(newAnnotation!);
    }
    
    func saveRoadEvent(event: RoadEvent) {
        //Save Road Event
        trip!.roadEvents.append(event);
        updateTripLocations()
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let event = trip!.eventForCoordinate(view.annotation!.coordinate);
        let index = trip!.roadEvents.indexOf(event!);
        
        trip!.roadEvents.removeAtIndex(index!);
        
        updateTripLocations();
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "createRoadEventSegue")
        {
            let next = segue.destinationViewController as! CreateRoadEventViewController
            next.coordinates = newCoords;
            next.delegate = self;
        }
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        //Add a hazard or other pin
        if(newCoords != nil)
        {
            performSegueWithIdentifier("createRoadEventSegue", sender: self);
        }
        else
        {
            //Show error dialog
            let alert = UIAlertController(title: "Error", message: "New location pin not set. Long press a spot on the map to add the new location pin.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil));
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func refreshButtonPressed(sender: AnyObject) {
        //Refresh user locations and pins
        updateTripLocations();
    }
}

extension UIImage {
    
    func colorized(color : UIColor) -> UIImage {
        let rect = CGRectMake(0, 0, self.size.width, self.size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0);
        let context = UIGraphicsGetCurrentContext();
        CGContextSetBlendMode(context, .Multiply)
        CGContextDrawImage(context, rect, self.CGImage)
        CGContextClipToMask(context, rect, self.CGImage)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let colorizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return colorizedImage
    }
}
