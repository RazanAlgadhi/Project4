//
//  AnnotationPin.swift
//  VirtualTouristRaz
//
//  Created by pc on 10/05/2023.
//

import Foundation
import MapKit

class AnnotationPin: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    var pin: Pin
    
    init(coordinate: CLLocationCoordinate2D, pin: Pin) {
        self.coordinate = coordinate
        self.pin = pin
    }
}
