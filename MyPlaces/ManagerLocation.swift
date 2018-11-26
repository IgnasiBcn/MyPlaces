//
//  ManagerLocation.swift
//  MyPlaces
//

//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation
import CoreLocation


class ManagerLocation: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    
    
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
        
        let clLocationCoordinate2D = (locationManager!.location?.coordinate)!
        print("ManagerLocation getLocation() cLLocationCoordinate2D: \(clLocationCoordinate2D)")
        // return (deviceLocationManager!.location?.coordinate)!
        return clLocationCoordinate2D
        
    }
    
    
    func startLocation() {
        
        print("3110 ManagerLocation startLocation()")
        print("- BEFORE locationManager.startUpdatingLocation()")
        locationManager.startUpdatingLocation()
        
    }
    
    
    //  *****************************************************************
    //  MARK: - extension CLLocationManagerDelegate
    //
    //  Protocol CLLocationManagerDelegate
    //  The methods that you use to receive events from an associated
    //  location manager object.
    //
    //
    /// Tells the delegate that the authorization status for the application changed.
    //
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
        
        print("5000 ManagerLocation locationManager(..., didChangeAuthorization...)")
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
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("6000 ManagerLocation locationManager(..., didUpdateLocations...)")
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("EEEE ManagerLocation locationManager(..., didFailWithError...)")
        print(error.localizedDescription)
        
    }
    
    
    
    //  *****************************************************************
    //  MARK: - SINGLETON Design Pattern
    //
    //  PLA3 - 1.5
    //
    //  Unique instance for all App
    //
    private static var sharedManagerLocation: ManagerLocation = {
        print("3100 ManagerLocation var sharedManagerLocation")
        
        var singletonManager: ManagerLocation?
        
        print("- singletonManager: \(String(describing: singletonManager))")
        if singletonManager == nil {
            
            singletonManager = ManagerLocation()
            
            singletonManager!.locationManager = CLLocationManager()
            
            singletonManager!.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            ////if CLLocationManager.locationServicesEnabled() {
            print("- CLLocationManager.locationServicesEnabled():  \(CLLocationManager.locationServicesEnabled())")
            
            singletonManager!.locationManager.delegate = singletonManager
            
            // The minimum distance (measured in meters) a device must move horizontally
            // before an update event is generated.
            singletonManager!.locationManager.distanceFilter = 500
            
            //--singletonManager!.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            singletonManager!.locationManager.allowsBackgroundLocationUpdates = true
            
            let status: CLAuthorizationStatus =
                CLLocationManager.authorizationStatus()
            
            print("- status: \(String(describing: status))")
            print("- status.rawValue: \(status.rawValue)")
            if status == .notDetermined {
                print("- status == .notDetermined")
                singletonManager!.locationManager.requestAlwaysAuthorization()
                print("- AFTER .requestWhenInUseAuthorization()")
                singletonManager!.startLocation()
            }
            else {
                singletonManager!.startLocation()
            }
        }
        
        print("- BEFORE return singletonManager)")
        return singletonManager!
    }()
    
    
    class func shared() -> ManagerLocation {
        print("3000 ManagerLocation shared()")
        return sharedManagerLocation
    }
}
