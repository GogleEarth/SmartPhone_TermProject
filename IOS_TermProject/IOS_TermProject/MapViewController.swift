//
//  PlayMapViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 30/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var MapView: MKMapView!
   
    var PLAY_FACLT_NM : String?
    var REFINE_LOTNO_ADDR : String?
    
    let regionRadius: CLLocationDistance = 500
    
    var playfaclts : [PlayFaclt] = []
    
    var xpos : Double = 0.0
    var ypos : Double = 0.0
    
    func loadInitialData()
    {
        let playfaclt = PlayFaclt(title: PLAY_FACLT_NM!, locationName: REFINE_LOTNO_ADDR!, coordinate: CLLocationCoordinate2D(latitude: ypos, longitude: xpos))
        playfaclts.append(playfaclt)
    }
    
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        MapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: ypos, longitude: xpos)
        centerMapOnLocation(location: initialLocation)
        MapView.delegate = self
        loadInitialData()
        MapView.addAnnotations(playfaclts)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        let location = view.annotation as! PlayFaclt
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        guard let annotation = annotation as? PlayFaclt else { return nil }
        
        let identifier = "marker"
        
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        {
            dequeuedView.annotation = annotation
            view = dequeuedView
        }
        else
        {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
    
}
