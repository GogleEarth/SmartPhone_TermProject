//
//  NursingFacltMapViewController.swift
//  IOS_TermProject
//
//  Created by  kpugame on 09/06/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit
import MapKit

class NursingFacltMapViewController: UIViewController, MKMapViewDelegate, XMLParserDelegate {
    @IBOutlet weak var MapView: MKMapView!
    
    var url : String = "https://openapi.gg.go.kr/ChildBringingUpFacility?KEY=edca732aac4047cabe0b0508aba9616d&pIndex=1&pSize=100"
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var FACLT_NM = NSMutableString() // 시설이름
    var REFINE_LOTNO_ADDR = NSMutableString() // 주소
    var FACLTCHEF_NM = NSMutableString() //시설장명
    var TELNO = NSMutableString() // 전화번호
    var ACEPTNC_CHILD_PSN_CAPA = NSMutableString() // 수용아동정원
    var ACEPTNC_CHILD_NOWPSN_CNT = NSMutableString() // 수용아동현재원
    var ENFLPSN_CNT = NSMutableString() // 종사자수
    var REFINE_WGS84_LOGT = NSMutableString() //xpos
    var REFINE_WGS84_LAT = NSMutableString() //ypos
    
    let regionRadius: CLLocationDistance = 100000
    
    var playfaclts : [PlayFaclt] = []
    
    var xpos : Double = 0.0
    var ypos : Double = 0.0
    
    var selected_post = 0
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf:( URL(string:url))!)!
        parser.delegate = self
        parser.parse()
    }
    
    func loadInitialData()
    {
        var index_num = 0
        for post in posts
        {
            let faclt_nm = (post as AnyObject).value(forKey: "FACLT_NM") as! NSString as String
            let addr = (post as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSString as String
            let XPos = (post as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSString as String
            let YPos = (post as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSString as String
            let lat = (YPos as NSString).doubleValue
            let lon = (XPos as NSString).doubleValue
            let playfaclt = PlayFaclt(title: faclt_nm, locationName: addr, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            playfaclt.index_num = index_num
            playfaclts.append(playfaclt)
            index_num = index_num + 1
        }
    }
    
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        MapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        let initialLocation = CLLocation(latitude: 37.5497121628, longitude: 127.0786363076)
        centerMapOnLocation(location: initialLocation)
        MapView.delegate = self
        loadInitialData()
        MapView.addAnnotations(playfaclts)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        let location = view.annotation as! PlayFaclt
        //let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        //location.mapItem().openInMaps(launchOptions: launchOptions)
        
        selected_post = location.index_num
        print(selected_post)
        let uvc = self.storyboard?.instantiateViewController(withIdentifier : "NurseDetail")
        if let nursingFacltDetailTableViewController = uvc as? NursingFacltDetailTableViewController
        {
            nursingFacltDetailTableViewController.FACLT_NM = (posts.object(at: selected_post) as AnyObject).value(forKey: "FACLT_NM") as! NSMutableString as String
            nursingFacltDetailTableViewController.REFINE_LOTNO_ADDR = (posts.object(at: selected_post) as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSMutableString as String
            nursingFacltDetailTableViewController.FACLTCHEF_NM = (posts.object(at: selected_post) as AnyObject).value(forKey: "FACLTCHEF_NM") as! NSMutableString as String
            nursingFacltDetailTableViewController.REFINE_WGS84_LOGT = (posts.object(at: selected_post) as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSMutableString as String
            nursingFacltDetailTableViewController.REFINE_WGS84_LAT = (posts.object(at: selected_post) as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSMutableString as String
            nursingFacltDetailTableViewController.TELNO = (posts.object(at: selected_post) as AnyObject).value(forKey: "TELNO") as! NSMutableString as String
            nursingFacltDetailTableViewController.ACEPTNC_CHILD_PSN_CAPA = (posts.object(at: selected_post) as AnyObject).value(forKey: "ACEPTNC_CHILD_PSN_CAPA") as! NSMutableString as String
            nursingFacltDetailTableViewController.ACEPTNC_CHILD_NOWPSN_CNT = (posts.object(at: selected_post) as AnyObject).value(forKey: "ACEPTNC_CHILD_NOWPSN_CNT") as! NSMutableString as String
            nursingFacltDetailTableViewController.ENFLPSN_CNT = (posts.object(at: selected_post) as AnyObject).value(forKey: "ENFLPSN_CNT") as! NSMutableString as String
        }
        uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        present(uvc!, animated: true, completion: nil)
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
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "row")
        {
            elements = NSMutableDictionary()
            elements = [:]
            FACLT_NM = NSMutableString()
            FACLT_NM = ""
            REFINE_LOTNO_ADDR = NSMutableString()
            REFINE_LOTNO_ADDR = ""
            FACLTCHEF_NM = NSMutableString()
            FACLTCHEF_NM = ""
            REFINE_WGS84_LOGT = NSMutableString()
            REFINE_WGS84_LOGT = ""
            REFINE_WGS84_LAT = NSMutableString()
            REFINE_WGS84_LAT = ""
            TELNO = NSMutableString()
            TELNO = ""
            ACEPTNC_CHILD_PSN_CAPA = NSMutableString()
            ACEPTNC_CHILD_PSN_CAPA = ""
            ACEPTNC_CHILD_NOWPSN_CNT = NSMutableString()
            ACEPTNC_CHILD_NOWPSN_CNT = ""
            ENFLPSN_CNT = NSMutableString()
            ENFLPSN_CNT = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "FACLT_NM")
        {
            FACLT_NM.append(string)
        }
        else if element.isEqual(to: "REFINE_LOTNO_ADDR")
        {
            REFINE_LOTNO_ADDR.append(string)
        }
        else if element.isEqual(to: "REFINE_WGS84_LOGT")
        {
            REFINE_WGS84_LOGT.append(string)
        }
        else if element.isEqual(to: "REFINE_WGS84_LAT")
        {
            REFINE_WGS84_LAT.append(string)
        }
        else if element.isEqual(to: "FACLTCHEF_NM"){
            FACLTCHEF_NM.append(string)
        }
        else if element.isEqual(to: "TELNO"){
            TELNO.append(string)
        }
        else if element.isEqual(to: "ACEPTNC_CHILD_PSN_CAPA"){
            ACEPTNC_CHILD_PSN_CAPA.append(string)
        }
        else if element.isEqual(to: "ACEPTNC_CHILD_NOWPSN_CNT"){
            ACEPTNC_CHILD_NOWPSN_CNT.append(string)
        }
        else if element.isEqual(to: "ENFLPSN_CNT"){
            ENFLPSN_CNT.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "row")
        {
            if !FACLT_NM.isEqual(nil)
            {
                elements.setObject(FACLT_NM, forKey: "FACLT_NM" as NSCopying)
            }
            if !REFINE_LOTNO_ADDR.isEqual(nil)
            {
                elements.setObject(REFINE_LOTNO_ADDR, forKey: "REFINE_LOTNO_ADDR" as NSCopying)
            }
            if !REFINE_WGS84_LOGT.isEqual(nil)
            {
                elements.setObject(REFINE_WGS84_LOGT, forKey: "REFINE_WGS84_LOGT" as NSCopying)
            }
            if !REFINE_WGS84_LAT.isEqual(nil)
            {
                elements.setObject(REFINE_WGS84_LAT, forKey: "REFINE_WGS84_LAT" as NSCopying)
            }
            if !FACLTCHEF_NM.isEqual(nil){
                elements.setObject(FACLTCHEF_NM, forKey: "FACLTCHEF_NM" as NSCopying)
            }
            if !TELNO.isEqual(nil){
                elements.setObject(TELNO, forKey: "TELNO" as NSCopying)
            }
            if !ACEPTNC_CHILD_PSN_CAPA.isEqual(nil){
                elements.setObject(ACEPTNC_CHILD_PSN_CAPA, forKey: "ACEPTNC_CHILD_PSN_CAPA" as NSCopying)
            }
            if !ACEPTNC_CHILD_NOWPSN_CNT.isEqual(nil){
                elements.setObject(ACEPTNC_CHILD_NOWPSN_CNT, forKey: "ACEPTNC_CHILD_NOWPSN_CNT" as NSCopying)
            }
            if !ENFLPSN_CNT.isEqual(nil){
                elements.setObject(ENFLPSN_CNT, forKey: "ENFLPSN_CNT" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailNursingInfo"
        {
            if let nursingFacltDetailTableViewController = segue.destination as? NursingFacltDetailTableViewController
            {
                nursingFacltDetailTableViewController.FACLT_NM = (posts.object(at: selected_post) as AnyObject).value(forKey: "FACLT_NM") as! NSMutableString as String
                nursingFacltDetailTableViewController.REFINE_LOTNO_ADDR = (posts.object(at: selected_post) as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSMutableString as String
                nursingFacltDetailTableViewController.FACLTCHEF_NM = (posts.object(at: selected_post) as AnyObject).value(forKey: "FACLTCHEF_NM") as! NSMutableString as String
                nursingFacltDetailTableViewController.REFINE_WGS84_LOGT = (posts.object(at: selected_post) as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSMutableString as String
                nursingFacltDetailTableViewController.REFINE_WGS84_LAT = (posts.object(at: selected_post) as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSMutableString as String
                nursingFacltDetailTableViewController.TELNO = (posts.object(at: selected_post) as AnyObject).value(forKey: "TELNO") as! NSMutableString as String
                nursingFacltDetailTableViewController.ACEPTNC_CHILD_PSN_CAPA = (posts.object(at: selected_post) as AnyObject).value(forKey: "ACEPTNC_CHILD_PSN_CAPA") as! NSMutableString as String
                nursingFacltDetailTableViewController.ACEPTNC_CHILD_NOWPSN_CNT = (posts.object(at: selected_post) as AnyObject).value(forKey: "ACEPTNC_CHILD_NOWPSN_CNT") as! NSMutableString as String
                nursingFacltDetailTableViewController.ENFLPSN_CNT = (posts.object(at: selected_post) as AnyObject).value(forKey: "ENFLPSN_CNT") as! NSMutableString as String
            }
        }
    }
}
