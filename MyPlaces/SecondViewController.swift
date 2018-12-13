//
//  SecondViewController.swift
//  MyPlaces
//
//  Created by iMac on 2/10/18.
//  Copyright © 2018 Ignasi Pérez. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController:
    UIViewController,
    MKMapViewDelegate,
    ManagerPlacesObserver {

    
//    let managerPlaces = ManagerPlaces.shared()
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    //  *****************************************************************
    //  MARK: - Overrided methods UIViewController
    //
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("1-1000 SecondViewController viewDidLoad()")
        addMyselfAsObserver()
        
        mapView.delegate = self
        
        addMarkers()
        
        print("1-1000 - BEFORE mapView.delegate = self")
        
    }

    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    //  *****************************************************************
    //  MARK: - MANAGE MARKERS ON THE MAP
    //
    //  PLA3 - 2.4.2
    //
    //  Add Markers or indicators from the ManagerPlaces
    //
    func addMarkers() {
       
        print("1-1200 SecondViewController addMarkers()")
        let managerPlaces = ManagerPlaces.shared()
        
        for i in 0..<managerPlaces.getCount() {
            let place = managerPlaces.getItemAt(position: i)
            
            let myPointAnnotation = MKMyPointAnnotaion(
                coordinate: CLLocationCoordinate2D(
                    latitude: place.location.latitude,
                    longitude: place.location.longitude),
                title: place.name,
                subtitle: place.description,
                place_id: place.id)
            
            print("1-1200 - BEFORE mapView.addAnnotation(mkMyPointAnnotation)")
            mapView.addAnnotation(myPointAnnotation)
        }
        print("1-1200 - BEFORE mapView.showAnnotations(mapView.annotations, animated: true)")
        mapView.showAnnotations(mapView.annotations, animated: true)
        
    }
    
    
    //  PLA3 - 2.4.1
    //
    func removeMarkers() {
        
        print("RRRR SecondViewController removeMarkers()")
        let userLocationAnnotations =
            mapView.annotations.filter { !($0 is MKUserLocation) }
        
        mapView.removeAnnotations(userLocationAnnotations)
        
    }
    
    
    //  *****************************************************************
    //  MARK: - extension MKMapViewDelegate
    //
    //  Protocol MKMapViewDelegate
    //  Optional methods that you use to receive map-related update messages.
    //
    //
    /// Returns the view associated with the specified annotation object.
    //
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        print("1-4000 SecondViewController mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation)")
        if let annotation = annotation as? MKMyPointAnnotaion {

            let identifier = "CustomPinAnnotationView"

            var pinAnnotationView: MKPinAnnotationView

            if let dequeuedView =
                self.mapView.dequeueReusableAnnotationView(
                    withIdentifier: identifier) as? MKPinAnnotationView {
                
                print("- let dequeuedView (TRUE)")
                dequeuedView.annotation = annotation
                pinAnnotationView = dequeuedView
            }
            else {
                print("- let dequeuedView (FALSE)")
                // Constructor superclass MKAnnotationView
                pinAnnotationView = MKPinAnnotationView(annotation: annotation,
                                              reuseIdentifier: identifier)
                pinAnnotationView.canShowCallout = true   // Super class MKAnnotationView

                pinAnnotationView.calloutOffset = CGPoint(x: -5, y: 5)    // Super class MKAnnotationView

                pinAnnotationView.rightCalloutAccessoryView =
                    UIButton(type: .detailDisclosure) as UIView // Super class MKAnnotationView

                // pinAnnotationView.setSelected(true, animated: true)
            }
            print("1-4000 - pinAnnotationView: \(pinAnnotationView)")
            return pinAnnotationView
        }
        return nil

    }
    

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("1-6000 SecondViewController mapView(... , didSelect: view: MKAnnotationView)")
        print("- view: \(String(describing: view.annotation?.title))")
    }
    
    
    /// Returns the view associated with the specified annotation object.
    //
    func mapView(_ mapView: MKMapView,
                 annotationView: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        print("&&&& SecondViewController mapView(mapView,..., calloutAccessoryControlTapped)")
        let annotation: MKMyPointAnnotaion =
            annotationView.annotation as! MKMyPointAnnotaion
        
        
        // Mostrar el DetailControler de ese Place
        let dc =
            UIStoryboard(name: "Main",bundle:nil).instantiateViewController(
                withIdentifier: "DetailController") as! DetailController
        
        let place: Place =
            ManagerPlaces.shared().getItemById(id: annotation.place_id)
        dc.place = place
        present(dc, animated: true, completion: nil)
        
    }
    
    
    
    //  Protocol MKMapViewDelegate
    /// Tells the delegate that one or more annotation views were added to the map.
    //
    func mapView(_: MKMapView, didAdd: [MKAnnotationView]) {
        
        print("1-5000 SecondViewController mapView(_: MKMapView, didAdd: [MKAnnotationView])")
        
    }
    
    
    
    //  *****************************************************************
    //  MARK: - OBSERVER Design Pattern
    //
    //
    //  PLA3 - 2.7.1
    //
    /// An instance of SecondViewController subscribes itself to the list of observers
    //
    func addMyselfAsObserver() {
        
        print("1-1100 SecondViewController addMyselfAsObserver()")
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
        
        print("1-7OOO SecondViewController onPlacesChange() BEFORE addMarkers()")
        
        removeMarkers()
        addMarkers()
        
    }
    
}
