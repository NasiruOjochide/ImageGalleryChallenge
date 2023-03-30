//
//  LocationFetcher.swift
//  ImageGalleryChallenge
//
//  Created by Danjuma Nasiru on 27/02/2023.
//

import CoreLocation
import Foundation
import MapKit

class LocationFetcher : NSObject, CLLocationManagerDelegate{
    
    let manager = CLLocationManager()
    var lastKnownLocation : MKCoordinateRegion?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map{
            lastKnownLocation = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
}
