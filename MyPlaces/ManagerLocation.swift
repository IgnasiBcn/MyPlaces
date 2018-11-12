//
//  ManagerLocation.swift
//  MyPlaces
//

//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation
import MapKit


class ManagerLocation: NSObject, CLLocationManagerDelegate {
    
    var clLocationManager: CLLocationManager!
    
//    static var pos: Int = 0
//    static var locations:[CLLocationCoordinate2D] = [
//        CLLocationCoordinate2D(latitude: 41.387834, longitude: 2.170130),
//        CLLocationCoordinate2D(latitude: 41.387834, longitude: 2.170130),
//        CLLocationCoordinate2D(latitude: 41.391980, longitude: 2.196036)]
    

    
//    static func getLocation() -> CLLocationCoordinate2D
//    {
//        pos += 1
//        if pos >= locations.count
//        {
//            pos = 0
//        }
//
//        return locations[pos]
//    }
    
    
    public func getLocation() -> CLLocationCoordinate2D {
        print("ManagerLocation getLocation()")
        let cLLocationCoordinate2D = (clLocationManager!.location?.coordinate)!
        print("ManagerLocation getLocation() cLLocationCoordinate2D: \(cLLocationCoordinate2D)")
        // return (deviceLocationManager!.location?.coordinate)!
        return cLLocationCoordinate2D
    }
    
    
    func startLocation()
    {
        print("ManagerLocation startLocation()")
        clLocationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("=== ManagerLocation locationManager(..., didChangeAuthorization...)")
        if status != .notDetermined {
            print("=== ManagerLocation locationManager(..., didChangeAuthorization...)")
            print("=== ManagerLocation locationManager(..., didChangeAuthorization...) - BEFORE startLocation()")
            startLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ManagerLocation locationManager(..., didFailWithError...)")
    }
    
    
    
    //  *******************************************************************
    //  MARK: - SINGLETON Design Pattern
    //
    //  PLA3 - 1.5
    //
    //  Unique instance for all App
    //
    private static var sharedManagerLocation: ManagerLocation = {
        print("*** ManagerLocation var sharedManagerLocation)")
        
        var singletonManager: ManagerLocation?
        
        print("*** ManagerLocation var sharedManagerLocation - singletonManager: \(String(describing: singletonManager))")
        if singletonManager == nil {
            
            singletonManager = ManagerLocation()
            
            singletonManager!.clLocationManager = CLLocationManager()
            
            ////if CLLocationManager.locationServicesEnabled() {
            singletonManager!.clLocationManager.delegate = singletonManager
            
            
            // The minimum distance (measured in meters) a device must move horizontally
            // before an update event is generated.
            singletonManager!.clLocationManager.distanceFilter = 500
            
            singletonManager!.clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            singletonManager!.clLocationManager.allowsBackgroundLocationUpdates = true
            
            let status: CLAuthorizationStatus =
                CLLocationManager.authorizationStatus()
            
            print("*** ManagerLocation var sharedManagerLocation - status: \(String(describing: status))")
            if status == .notDetermined {
                singletonManager!.clLocationManager.requestWhenInUseAuthorization()
            }
            else {
                singletonManager!.startLocation()
            }
        }
        
        print("*** ManagerLocation var sharedManagerLocation - BEFORE return singletonManager)")
        return singletonManager!
    }()
    
    
    class func shared() -> ManagerLocation {
        print("ManagerLocation shared()")
        return sharedManagerLocation
    }
}
