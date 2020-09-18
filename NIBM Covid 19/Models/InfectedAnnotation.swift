//
//  InfectedAnnotation.swift
//  NIBM Covid 19
//
//  Created by TM on 9/18/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import MapKit

class InfectedAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var uid: String
    
    init(uid: String, coordinate: CLLocationCoordinate2D) {
        self.uid = uid
        self.coordinate = coordinate
    }
    
    func updateAnnotationPosition(withCoordinate coordinate: CLLocationCoordinate2D) {
        UIView.animate(withDuration: 0.2) {
            self.coordinate = coordinate
        }
    }
}
