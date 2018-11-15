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
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("____ SecondViewController viewDidLoad()")
        addMyselfAsObserver()
        
        addMarkers()
    }

    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //  *******************************************************************
    //  MARK: - MANAGE MARKERS ON THE MAP
    //
    func addMarkers() {
       
        print("____ SecondViewController addMakers()")
        let managerPlaces = ManagerPlaces.shared()
        
        for i in 0..<managerPlaces.getCount() {
            let place = managerPlaces.getItemAt(position: i)
            
            let mkMyPointAnnotation = MKMyPointAnnotaion(
                coordinate: CLLocationCoordinate2D(
                    latitude: place.location.latitude,
                    longitude: place.location.longitude),
                title: place.name,
                place_id: place.id)
            
            mkMapView.addAnnotation(mkMyPointAnnotation)
        }
        
    }
    
    
    func removeMarkers() {
        
        print("SecondViewController removeMakers()")
        let userLocationAnnotations =
            mkMapView.annotations.filter { !($0 is MKUserLocation) }
        
        mkMapView.removeAnnotations(userLocationAnnotations)
    }
    
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        print("SecondViewController mapView(mapView, annotation)")
        if let annotation = annotation as? MKMyPointAnnotaion {
            
            let identifier = "CustomPinAnnotationView"
            
            var pinView: MKPinAnnotationView
            
            if let dequeuedView =
                mkMapView?.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                pinView = dequeuedView
            }
            else {
                pinView = MKPinAnnotationView(annotation: annotation,
                                              reuseIdentifier: identifier)
                pinView.canShowCallout = true   // Super class MKAnnotationView
                
                pinView.calloutOffset = CGPoint(x: -5, y: 5)    // Super class MKAnnotationView
                
                pinView.rightCalloutAccessoryView =
                    UIButton(type: .detailDisclosure) as UIView // Super class MKAnnotationView
                
                pinView.setSelected(true, animated: true)
            }
            
            return pinView
        }
        
        return nil
    }
    

    
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        let annotation = view.annotation as! MKMyPointAnnotaion
        
        print("SecondViewController mapView(mapView,..., calloutAccessoryControlTapped)")
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
        print("____ SecondViewController onPlacesChange()")
    }
    
}

