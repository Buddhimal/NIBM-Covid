//
//  HandleLocation.swift
//  NIBM Covid 19
//
//  Created by TM on 9/14/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import CoreLocation

class HandleLocation: NSObject, CLLocationManagerDelegate {
    static let shared = HandleLocation()
    var locationManager: CLLocationManager!
    var location: CLLocation?
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
}
