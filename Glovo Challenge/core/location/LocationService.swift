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
    var updatedCoordinates: (_ auhtorized: Bool) -> () = { authorized in }
    typealias completionLocation = (_ address: CLPlacemark?, _ error: Error?) -> Void
    
    private var locationManager = CLLocationManager()
    private let authStatus = CLLocationManager.authorizationStatus()
    
    override init() {
        super.init()
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.delegate = self
    }
    
    func getAddress(_ completion: @escaping completionLocation) {
        self.currentLocation = locationManager.location
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(self.currentLocation) { placeMark, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let address = placeMark?.first {
                completion(address, nil)
            }
        }
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .notDetermined:
            print("locatization cannot be determined yet")
        case .denied:
            updatedCoordinates(false)
        case .authorizedAlways, .authorizedWhenInUse:
            self.currentLocation = locationManager.location
            updatedCoordinates(true)
        @unknown default:
            fatalError("localization cannot be determined")
        }
    }
}
