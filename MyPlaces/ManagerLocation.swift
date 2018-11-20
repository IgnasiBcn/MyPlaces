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
        
        let clLocationCoordinate2D = (clLocationManager!.location?.coordinate)!
        print("ManagerLocation getLocation() cLLocationCoordinate2D: \(clLocationCoordinate2D)")
        // return (deviceLocationManager!.location?.coordinate)!
        return clLocationCoordinate2D
        
    }
    
    
    func startLocation() {
        
        print("ManagerLocation startLocation()")
        clLocationManager.startUpdatingLocation()
        
    }
    
    
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
        
        print("ManagerLocation locationManager(..., didChangeAuthorization...)")
        print("- status.rawValue: \(status.rawValue)")
        
        switch status {
        case .restricted, .denied:
            
            break
            
        case .authorizedWhenInUse:
            
            break
            
        case .notDetermined, .authorizedAlways:
            
            break
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("EEEE ManagerLocation locationManager(..., didFailWithError...)")
        print(error.localizedDescription)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("ManagerLocation locationManager(..., didUpdateLocations...)")
    }
    
    
    
    //  *******************************************************************
    //  MARK: - SINGLETON Design Pattern
    //
    //  PLA3 - 1.5
    //
    //  Unique instance for all App
    //
    private static var sharedManagerLocation: ManagerLocation = {
        print("SSSS ManagerLocation var sharedManagerLocation")
        
        var singletonManager: ManagerLocation?
        
        print("SSSS ManagerLocation var sharedManagerLocation - singletonManager: \(String(describing: singletonManager))")
        if singletonManager == nil {
            
            singletonManager = ManagerLocation()
            
            singletonManager!.clLocationManager = CLLocationManager()
            
            singletonManager!.clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            ////if CLLocationManager.locationServicesEnabled() {
            print("SSSS ManagerLocation var sharedManagerLocation CLLocationManager.locationServicesEnabled() - \(CLLocationManager.locationServicesEnabled())")
            
            singletonManager!.clLocationManager.delegate = singletonManager
            
            // The minimum distance (measured in meters) a device must move horizontally
            // before an update event is generated.
            singletonManager!.clLocationManager.distanceFilter = 500
            
            //--singletonManager!.clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            singletonManager!.clLocationManager.allowsBackgroundLocationUpdates = true
            
            let status: CLAuthorizationStatus =
                CLLocationManager.authorizationStatus()
            
            print("SSSS ManagerLocation var sharedManagerLocation - status: \(String(describing: status))")
            print("- status.rawValue: \(status.rawValue)")
            if status == .notDetermined {
                print("*** ManagerLocation var sharedManagerLocation - status == .notDetermined")
                singletonManager!.clLocationManager.requestWhenInUseAuthorization()
                print("*** ManagerLocation var sharedManagerLocation - AFTER .requestWhenInUseAuthorization()")
                singletonManager!.startLocation()
            }
            else {
                singletonManager!.startLocation()
            }
        }
        
        print("SSSS ManagerLocation var sharedManagerLocation - BEFORE return singletonManager)")
        return singletonManager!
    }()
    
    
    class func shared() -> ManagerLocation {
        print("SSSS ManagerLocation shared()")
        return sharedManagerLocation
    }
}
