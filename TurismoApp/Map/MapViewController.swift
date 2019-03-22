//
//  MapViewController.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 15/03/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var latitud:Double?
    var longitud:Double?
    let regionRadius: CLLocationDistance = 500
    
    var namePlace:String?
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let latitud = latitud, let longitud = longitud, let  namePlace = namePlace else{
            return
        }
        let initialLocation = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        mapView.addAnnotation(PlaceMap(title: namePlace, coordinate: initialLocation))
        centerMapOnLocation(location: initialLocation)
}
    
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion.init(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }



}
