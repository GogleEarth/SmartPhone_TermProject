//
//  PlayFaclt.swift
//  IOS_TermProject
//
//  Created by  kpugame on 30/05/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class PlayFaclt: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    init?(json: [Any])
    {
        self.title = json[16] as? String ?? "No Title"
        self.locationName = json[12] as! String
        
        if let latitude = Double(json[18] as! String), let longitude = Double(json[19] as! String)
        {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        else
        {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
    var subtitle: String?
    {
        return locationName
    }
    
    func mapItem() -> MKMapItem
    {
        let addressDict = [CNPostalAddressStreetKey: subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict as [String : Any])
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
