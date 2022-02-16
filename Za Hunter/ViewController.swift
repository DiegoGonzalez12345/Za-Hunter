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
    var selectedShop: PizzaShop!

    

    var shops: [MKMapItem] = []
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nvc = segue.destination as! DetailsViewController
       // nvc.currentPizzaShop = selectedShop
        
        
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])

    {
        currentLocation = locations[0]
    }
    
    @IBAction func whenSearchButtonPressed(_ sender: UIBarButtonItem)
    {

       let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "Pizza Shops"
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        var shops: [MKMapItem] = []
        
        
        
        let center = currentLocation.coordinate
        let region = MKCoordinateRegion(center: center, span: span)
        searchRequest.region = MKCoordinateRegion(center: center, span: span)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
        guard let response = response else { return }
        for mapItem in response.mapItems {
        self.shops.append(mapItem)
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapItem.placemark.coordinate
        annotation.title = mapItem.name
        self.mapView.addAnnotation(annotation)
        self.mapView.setRegion(region, animated: true)
            
            self.shops.append(mapItem)
            
            
        
    }
            func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
                if annotation.isEqual(mapView.userLocation) {
                    return nil
                }
                
                let pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
                pin.image=UIImage(named: "Pizza")
                
                
                pin.canShowCallout = true
                let button = UIButton(type:.detailDisclosure)
                pin.rightCalloutAccessoryView = button
                return pin
                }
        

        }
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            var currentMapItem = MKMapItem()
            
            if let title = view.annotation?.title, let shopName = title {
                for mapItem in shops {
                    if mapItem.name == shopName {
                    currentMapItem = mapItem
                }
            }
            
        }
            let placemark = currentMapItem.placemark
            let name = placemark.name ?? "Unknown Shop Name"
            let state = placemark.administrativeArea ?? "Unknown State"
            let city = placemark.locality ?? "Unknown City"
            let street = placemark.thoroughfare ?? "No Street Address"
            let streetNumber = placemark.subThoroughfare ?? "No Street Number"
            
            let fullAddressString = "\(streetNumber) \(street), \(city), \(state)"
            
            selectedShop = PizzaShop(name: name, address: fullAddressString)
            
            performSegue(withIdentifier: "shopInfo", sender: nil)
        }
        
        

    
func whenZoomButtonPressed(_ sender: Any)
    {

        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let center = currentLocation.coordinate
        let region = MKCoordinateRegion(center: center, span: coordinateSpan)
       // mapView.setRegion(region, animated: true)
        
        
    }
}

}
