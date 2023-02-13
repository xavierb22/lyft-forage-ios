//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            isLocationServiceEnabled()
        }
        
        
        func isLocationServiceEnabled(){
            if CLLocationManager.locationServicesEnabled(){
                checkAuthorizationStatus()
            }
            else{
                displayAlert(isServiceEnabled: true)
            }
        }
        
        func checkAuthorizationStatus(){
            
            let status = CLLocationManager.authorizationStatus()
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                mapView.showsUserLocation = true
            }
            else if status == .restricted || status == .denied {
                displayAlert(isServiceEnabled: false)
            }
            else if status == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
                mapView.showsUserLocation = true
            }
            
        }
        
        func displayAlert(isServiceEnabled:Bool){
            let serviceEnableMessage = "Location services must to be enabled to use this feature. You can enable location services in your settings."
            let authorizationStatusMessage = "This app needs authorization to find your location"
            
            let message = isServiceEnabled ? serviceEnableMessage : authorizationStatusMessage
            
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
            //create ok button
            let acceptAction = UIAlertAction(title: "OK", style: .default)
            
            //add ok button to alert
            alert.addAction(acceptAction)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
