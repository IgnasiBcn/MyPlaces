//
//  SecondViewController.swift
//  MyPlaces
//
//  Created by iMac on 2/10/18.
//  Copyright © 2018 Ignasi Pérez. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController,
                            MKMapViewDelegate,
                            ManagerPlacesObserver {

    
    @IBOutlet weak var mkMapView: MKMapView!
    
    
    
    //  *******************************************************************
    //  MARK: - Overrided methods
    //
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("____ SecondViewController viewDidLoad()")
        addMyselfAsObserver()
        
        addMarkers()
        
        mkMapView.delegate = self
        
    }

    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    //  *******************************************************************
    //  MARK: - MANAGE MARKERS ON THE MAP
    //
    //  PLA3 - 2.4.2
    //
    //  Add Markers or indicators from the ManagerPlaces
    //
    func addMarkers() {
       
        print("==== SecondViewController addMarkers()")
        let managerPlaces = ManagerPlaces.shared()
        
        for i in 0..<managerPlaces.getCount() {
            let place = managerPlaces.getItemAt(position: i)
            
            let mkMyPointAnnotation = MKMyPointAnnotaion(
                coordinate: CLLocationCoordinate2D(
                    latitude: place.location.latitude,
                    longitude: place.location.longitude),
                title: place.name,
                subtitle: "My Subtitle",
                place_id: place.id)
            
            print("==== SecondViewController addMarkers() - BEFORE mkMapView.addAnnotation(mkMyPointAnnotation)")
            mkMapView.addAnnotation(mkMyPointAnnotation)
        }
        print("-- BEFORE mkMapView.showAnnotations(mkMapView.annotations, animated: true)")
        mkMapView.showAnnotations(mkMapView.annotations, animated: true)
        
    }
    
    
    //  PLA3 - 2.4.1
    //
    func removeMarkers() {
        
        print("RRRR SecondViewController removeMarkers()")
        let userLocationAnnotations =
            mkMapView.annotations.filter { !($0 is MKUserLocation) }
        
        mkMapView.removeAnnotations(userLocationAnnotations)
        
    }
    
    
    
    //  *******************************************************************
    //  MARK: - MKMapView Protocols
    //
    //  Protocol MKMapViewDelegate
    /// Returns the view associated with the specified annotation object.
    //
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        print(">>>> SecondViewController mapView(mapView, annotation)")
        if let annotation = annotation as? MKMyPointAnnotaion {
            
            let identifier = "CustomPinAnnotationView"
            
            var pinView: MKPinAnnotationView
            
            if let dequeuedView =
                mkMapView?.dequeueReusableAnnotationView(withIdentifier:
                    identifier) as? MKPinAnnotationView {
                print("--> let dequeuedView (TRUE)")
                dequeuedView.annotation = annotation
                pinView = dequeuedView
            }
            else {
                print("--> let dequeuedView (FALSE)")
                // Constructor superclass MKAnnotationView
                pinView = MKPinAnnotationView(annotation: annotation,
                                              reuseIdentifier: identifier)
                pinView.canShowCallout = true   // Super class MKAnnotationView
                
                pinView.calloutOffset = CGPoint(x: -5, y: 5)    // Super class MKAnnotationView
                
                pinView.rightCalloutAccessoryView =
                    UIButton(type: .detailDisclosure) as UIView // Super class MKAnnotationView
                
                pinView.setSelected(true, animated: true)
            }
            print(">>>> SecondViewController mapView(mapView, annotation)")
            print("- pinView: \(pinView)")
            return pinView
        }
        return nil
        
    }
    

    //  Protocol MKMapViewDelegate
    /// Returns the view associated with the specified annotation object.
    //
    func mapView(_ mapView: MKMapView,
                 annotationView: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        print("&&&& SecondViewController mapView(mapView,..., calloutAccessoryControlTapped)")
        let annotation: MKMyPointAnnotaion =
            annotationView.annotation as! MKMyPointAnnotaion
        
        
        // Mostrar el DetailControler de ese Place
        
    }
    
    
    
    //  *******************************************************************
    //  MARK: - OBSERVER Design Pattern
    //
    //
    //  PLA3 - 2.7.1
    //
    /// An instance of SecondViewController subscribes itself to the list of observers
    //
    func addMyselfAsObserver() {
        
        print("____ SecondViewController addMyselfAsObserver()")
        ManagerPlaces.shared().addObserver(object: self)
        
    }
    
    
    //  PLA3 - 2.7.1
    //
    //  Protocol ManagerPlacesObserver
    //
    /// Because an instance of the SecondViewController class is subscribed,
    /// when the publisher discloses a change the subscriber acts according to his responsibilities.
    /// In this case SecondViewcontroller is responsible for loading the Markers on the map
    //
    func onPlacesChange() {
        
//        let view: UITableView = (self.view as? UITableView)!
//        view.reloadData()
        print("OOOO SecondViewController onPlacesChange() BEFORE addMarkers()")
        
        addMarkers()
        
    }
    
}
