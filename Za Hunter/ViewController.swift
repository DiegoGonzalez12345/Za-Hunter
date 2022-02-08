//
//  ViewController.swift
//  Za Hunter
//
//  Created by Diego Gonzalez on 1/31/22.
//

import MapKit
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
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
        mapView.delegate = self
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])

    {
        currentLocation = locations[0]
    }
    
    @IBAction func whenSearchButtonPressed(_ sender: Any)
    {

       let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Pizza Shops"
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let center = currentLocation.coordinate
        let region = MKCoordinateRegion(center: center, span: span)
        request.region = MKCoordinateRegion(center: center, span: span)
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
        guard let response = response else { return }
        for mapItem in response.mapItems {
        self.parks.append(mapItem)
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapItem.placemark.coordinate
        annotation.title = mapItem.name
        self.mapView.addAnnotation(annotation)
        self.mapView.setRegion(region, animated: true)
        
        
    }
//            func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView{
//
//
//        }


        }

    }
    
    @IBAction func whenZoomButtonPressed(_ sender: Any)
    {
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let center = currentLocation.coordinate
        let region = MKCoordinateRegion(center: center, span: coordinateSpan)
        mapView.setRegion(region, animated: true)
        
        
    }
  }

