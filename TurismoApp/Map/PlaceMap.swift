//
//  PlaceMap.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 20/03/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import MapKit
import UIKit


class PlaceMap: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D

    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title!
        self.coordinate = coordinate
       
    }
}
