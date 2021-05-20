//
//  Station.swift
//  E_Vehicle_TeamProject
//
//  Created by kpugame on 2021/05/21.
//
import Foundation
import MapKit

import Contacts

class Station: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D

    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }

    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStateKey:subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
        
    }
}
