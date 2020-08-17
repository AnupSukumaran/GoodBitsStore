//
//  NSObject+Ext.swift
//  GoodBitsStore
//
//  Created by Sukumar Anup Sukumaran on 17/08/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import Foundation
import CoreLocation

extension NSObject {
    
    static var identifier: String {
        String(describing: self)
    }
    
    func getDistance(coord1: (lat: CLLocationDegrees, long: CLLocationDegrees), coord2: (lat: CLLocationDegrees, long: CLLocationDegrees)) -> CLLocationDistance {
        let startPoint = CLLocation(latitude: coord1.lat, longitude: coord1.long)
        let stopPoint = CLLocation(latitude: coord2.lat, longitude: coord2.long)
        return startPoint.distance(from: stopPoint)
    }
    
}
