//
//  LocationService.swift
//  Glovo Challenge
//
//  Created by Carlos Vázquez Gómez on 4/20/19.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    var currentLocation: CLLocation!
    var updatedCoordinates: () -> () = {}
    var addressObject: (_ address: CLPlacemark?, _ error: Error?) -> () = { address, error in }
    
    private let locationManager = CLLocationManager()
    private let authStatus = CLLocationManager.authorizationStatus()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func getAddress() {
        if authStatus == CLAuthorizationStatus.authorizedAlways || authStatus == CLAuthorizationStatus.authorizedWhenInUse {
            self.currentLocation = locationManager.location
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(self.currentLocation) { [weak self] placeMark, error in
                guard let strongSelf = self else { return }
                
                if let error = error {
                    strongSelf.addressObject(nil, error)
                    return
                }
                
                if let address = placeMark?.first {
                    strongSelf.addressObject(address, nil)
                }
            }
        }
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied, .notDetermined:
            print("locatization not authorized or not determined")
        case .authorizedAlways, .authorizedWhenInUse:
            self.currentLocation = locationManager.location
            updatedCoordinates()
        @unknown default:
            fatalError("localization cannot be determined")
        }
    }
}
