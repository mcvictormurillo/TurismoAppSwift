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
    let regionRadius: CLLocationDistance = 1000
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: latitud!, longitude: longitud!)
        centerMapOnLocation(location: initialLocation)
}
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)//MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }



}
