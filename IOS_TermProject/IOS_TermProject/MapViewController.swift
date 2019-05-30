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
   
    var posts = NSMutableArray()
    
    let regionRadius: CLLocationDistance = 5000
    
    var playfaclts : [PlayFaclt] = []
    
    var xpos : Float = 0.0
    var ypos : Float = 0.0
    
    func loadInitialData()
    {
        for post in posts
        {
            let yadmNm = (post as AnyObject).value(forKey: "yadmNm") as! NSString as String
            let addr = (post as AnyObject).value(forKey: "addr") as! NSString as String
            let XPos = (post as AnyObject).value(forKey: "XPos") as! NSString as String
            let YPos = (post as AnyObject).value(forKey: "YPos") as! NSString as String
            let lat = (YPos as NSString).doubleValue
            let lon = (XPos as NSString).doubleValue
            let playfaclt = PlayFaclt(title: yadmNm, locationName: addr, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            playfaclts.append(playfaclt)
        }
    }
    
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        MapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: CLLocationDegrees(ypos), longitude: CLLocationDegrees(xpos))
        centerMapOnLocation(location: initialLocation)
        MapView.delegate = self
        loadInitialData()
        MapView.addAnnotations(playfaclts)
        // Do any additional setup after loading the view.
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
