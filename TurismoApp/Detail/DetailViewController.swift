//
//  DetailViewController.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 28/02/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import UIKit
import Foundation
class DetailViewController: UIViewController {

    
    
    @IBOutlet var learnMoreButton: UIButton!
    var place: Place?
    var placeManager = PlacesManager()
    @IBOutlet var titleDetailLabel: UILabel!
    @IBOutlet var imageDetail: UIImageView!
    @IBOutlet var descriptionText: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleDetailLabel.text = place!.name
        imageDetail.image = place!.image
        descriptionText.text = place!.description
        
        //Bordes para el boton
        learnMoreButton.layer.borderColor =  UIColor.lightGray.cgColor
        learnMoreButton.layer.borderWidth = 0.7
        learnMoreButton.layer.cornerRadius = 5
        
        //print(place!)
    }
    

    @IBAction func touchAddFavorite(_ sender: UIButton) {
      if placeManager.addPlaceFavorite(place!){
            AlertCustom().alert(controller: self, message: "Add to Favorite",second:1.2)
            DataFavorite.actualizar = true
        }
        else{
            AlertCustom().alert(controller: self, message: " No Added to Favorite",second:1.2)
        }
        
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
       if let mapVC = segue.destination as? MapViewController{
        var latLong = place!.geo.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
            mapVC.namePlace = place!.name
            mapVC.latitud = Double(latLong[0])
            mapVC.longitud = Double(latLong[1])
        
       
       
        }
    }
    
    
}




