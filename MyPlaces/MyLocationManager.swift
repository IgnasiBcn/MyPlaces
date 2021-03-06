//
//  MyLocationManager.swift
//  MyPlaces
//

//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation
import CoreLocation
import UserNotifications


class MyLocationManager:
    NSObject,
    CLLocationManagerDelegate {
    
    private var locationManager: CLLocationManager!
    
    var firstTime = true
    
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
        print("MyLocationManager getLocation() cLLocationCoordinate2D: \(clLocationCoordinate2D)")
        // return (deviceLocationManager!.location?.coordinate)!
        return clLocationCoordinate2D
        
    }
    
    
    private func startLocation() {
        
        print("0-3200 MyLocationManager startLocation()")
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
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        
        print("P-2000 MyLocationManager locationManager(..., didChangeAuthorization...)")
        print("- status.rawValue: \(status.rawValue)")
        
        switch status {
        case .restricted, .denied:
            
            break
    
        case .notDetermined:
            
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            print("- BEFORE  startLocation()")
            startLocation()
            
            break
        }
        
    }
    
    
    //  PLA4 - 2.1
    //
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        print("P-2100 MyLocationManager locationManager(..., didUpdateLocations...)")
        let location: CLLocation = locations[locations.endIndex-1]
        print("- location: \(location)")
        
        print("- firstTime: \(firstTime)")
        if firstTime {
            let content = UNMutableNotificationContent()
            content.title = "Message title"
            content.subtitle = "Message subtitle"
            content.body = "Message body"
            content.badge = 1
            
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 10,
                repeats: false)
            
            let requestIdentifier = "demoNotification"
            
            let request = UNNotificationRequest(
                identifier: requestIdentifier,
                content: content,
                trigger: trigger)
            
            UNUserNotificationCenter.current().add(
                request,
                withCompletionHandler: { (error) in
                    // Handle error
                })
            
            print("- BEFORE firstTime = false")
            // firstTime = false
            
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        
        print("EEEE MyLocationManager locationManager(..., didFailWithError...)")
        print(error.localizedDescription)
        
    }
    
    
    
    //  *****************************************************************
    //  MARK: - SINGLETON Design Pattern
    //
    //  PLA3 - 1.5
    //
    //  Unique instance for all App
    //
    private static var sharedManagerLocation: MyLocationManager = {
        print("0-3000 ManagerLocation var sharedManagerLocation")
        
        var singletonManager: MyLocationManager?
        
        print("- singletonManager: \(String(describing: singletonManager))")
        if singletonManager == nil {
            
            singletonManager = MyLocationManager()
            
            singletonManager!.locationManager = CLLocationManager()
            
            singletonManager!.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            ////if CLLocationManager.locationServicesEnabled() {
            print("- CLLocationManager.locationServicesEnabled() - \(CLLocationManager.locationServicesEnabled())")
            
            singletonManager!.locationManager.delegate = singletonManager
            
            // The minimum distance (measured in meters) a device must move horizontally
            // before an update event is generated.
            singletonManager!.locationManager.distanceFilter = 500
            
            //--singletonManager!.clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            singletonManager!.locationManager.allowsBackgroundLocationUpdates = true
            
            let status: CLAuthorizationStatus =
                CLLocationManager.authorizationStatus()
            
            print("- status: \(String(describing: status))")
            print("- status.rawValue: \(status.rawValue)")
            if status == .notDetermined {
                print("- status == .notDetermined")
                singletonManager!.locationManager.requestWhenInUseAuthorization()
                print("- AFTER .requestWhenInUseAuthorization()")
            }
            else {
                singletonManager!.startLocation()
            }
        }
        
        
        let userNotificationCenter = UNUserNotificationCenter.current()
        
        userNotificationCenter.requestAuthorization(
        options: [.alert, .sound, .badge]) {
            (grant, error) in
            // enable or disable features based on authorization
        }
        
        print("- BEFORE return singletonManager)")
        return singletonManager!
    }()
    
    
    class func shared() -> MyLocationManager {
    
        return sharedManagerLocation
    
    }
    
}
