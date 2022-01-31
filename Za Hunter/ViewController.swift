//
//  ViewController.swift
//  Za Hunter
//
//  Created by Diego Gonzalez on 1/31/22.
//

import MapKit
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate
{
    
    @IBOutlet weak var mapView: MKMapView!
    
let locationManager = CLLocationManager()
var currentLocation : CLLocation!


    

    var parks: [MKMapItem] = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
       locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])

    {
currentLocation = locations[0]
    }

}


