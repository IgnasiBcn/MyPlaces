//
//  MKMyPointAnnotation.swift
//  MyPlaces
//
//  Created by iMac on 12/11/18.
//  Copyright © 2018 Ignasi Pérez. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class MKMyPointAnnotaion : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var place_id: String = ""
    
    
    init(coordinate: CLLocationCoordinate2D, title: String,
         subtitle: String, place_id: String) {
        
        print("____ MKMyPointAnnotaion - init(coordinate, title, subtitle, place_id)")
        print("- title: \(title), place_id: \(place_id)")
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.place_id = place_id
        
    }
    
}
