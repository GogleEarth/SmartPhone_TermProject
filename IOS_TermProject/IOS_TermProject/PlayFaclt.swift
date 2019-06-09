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
    var index_num : Int
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.index_num = 0
        
        super.init()
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
