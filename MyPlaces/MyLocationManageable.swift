//
//  MyLocationManageable.swift
//  MyPlaces
//
//  Created by user on 28/11/2018.
//  Copyright © 2018 Ignasi Pérez. All rights reserved.
//

import Foundation
import CoreLocation

protocol MyLocationManegeable {
    
    func getLocation() -> CLLocationCoordinate2D
    
}

extension MyLocationManegeable {
    
    func getLocation() -> CLLocationCoordinate2D {
        
        return MyLocationManager.shared().getLocation()
        
    }
    
}

