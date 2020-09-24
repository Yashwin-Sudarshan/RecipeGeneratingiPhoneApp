//
//  AddressFinderViewController.swift
//  RecipeSolved
//
//  Created by Ruby Rio on 21/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//
import UIKit
import CoreLocation
import MapKit

class LocationSelector: UIViewController {
    
    
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    private var previousPoint: CLLocation?
    
    
    fileprivate var totalMovementDistance = CLLocationDistance(10)
    
    @IBAction func searchForLocation(_ sender: Any) {
        guard let targetAddress = location.text else{
            return
        }
        
        // Co-Ordinates
        let geoCoder = CLGeocoder()
        var coords: CLLocationCoordinate2D?
        
        //Map Visibility
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        geoCoder.geocodeAddressString(targetAddress, completionHandler: {
            (placemarks:[CLPlacemark]?, error: Error?) -> Void in
            if let placemark = placemarks?[0]
            {
                // Convert the address to a coordinate
                let location = placemark.location
                coords = location!.coordinate
                
                // Set the map to the coordinate
                let region = MKCoordinateRegion(center: coords!, span: span)
                self.mapView.region = region
                
                // Add a pin to the address location
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
            }
        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func requestAuthorisation(_ sender: Any)
    {
        //Authorisation Settings
        switch CLLocationManager.authorizationStatus()
        {
        case .authorizedAlways, .authorizedWhenInUse, .notDetermined:
            customAlert(title: "Location Feature Authorised", message: "Go to Settings to Restrict Permissions", actionTitle: "Cancel")
            
        case .denied:
            customAlert(title: "Location Feature Restricted", message: "Go to Settings to Change Permissions", actionTitle: "Cancel")
            
        case .restricted:
            break
        }
    }
    
    
    // Settings Navigation
    func customAlert(title: String, message: String, actionTitle: String)
    {
        let alert = UIAlertController (title: title, message: message, preferredStyle: .alert)
        let settingsAction = goToSettings()
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)        
        present(alert, animated: true, completion: nil)
    }
    
    
    func goToSettings() -> UIAlertAction{
        return UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
    }
}


extension LocationSelector: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        print("Authorisation status changed to \(status.rawValue)")
        switch status{
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        default:
            locationManager.stopUpdatingLocation()
            mapView.showsUserLocation = false
        }
        
    }
    
}

