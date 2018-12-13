//
//  AppDelegate.swift
//  MyPlaces
//
//  Created by iMac on 2/10/18.
//  Copyright © 2018 Ignasi Pérez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    // let manager = ManagerPlaces.shared()
    
    
    /// Override point for customization after application launch.
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool {
            
//        let place1 = Place(name: "Value name place1", description: "Value description place1", image_in: nil)
//        let place2 = Place(name: "Value name place2", description: "Value description place2", image_in: nil)
//        manager.append(place1)
//        manager.append(place2)
            
            print("AppDelegate application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)")

        return true
    }

    
    /// Sent when the application is about to move from active to inactive state.
    /// This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    //
    /// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks.
    /// Games should use this method to pause the game.
    //
    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    
    /// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    //
    /// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    
    /// Called as part of the transition from the background to the active state;
    /// Here you can undo many of the changes made on entering the background.
    //
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    
    /// Restart any tasks that were paused (or not yet started) while the application was inactive.
    /// If the application was previously in the background, optionally refresh the user interface.
    //
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    
    func applicationWillTerminate(_ application: UIApplication) {
        
        // Called when the application is about to terminate. Save data if appropriate.
        // See also applicationDidEnterBackground:.
    }
}
