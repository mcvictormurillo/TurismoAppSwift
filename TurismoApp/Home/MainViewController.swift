//
//  MainViewController.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 17/03/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,URLSessionDelegate {

    @IBOutlet var collectionViewMain: UICollectionView!
    @IBOutlet var floatButtonScanner: UIButton!
    let jsonUrlString = "http://192.168.43.103:5000/"
    
    var placesServices:PlaceServiceProtocol = PlaceService()
    lazy var places:[Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: (self.collectionViewMain.frame.size.width - 20)/2 , height: (self.collectionViewMain.frame.size.height)/3)
        layout.minimumInteritemSpacing = 5 //3
        collectionViewMain.collectionViewLayout = layout
        floatButtonScanner.layer.cornerRadius = floatButtonScanner.frame.height/2 
        loadPlaces()
}
    
    func loadPlaces() {
        placesServices.getPlace(with: jsonUrlString) {
            (listPlaces, error) in
            if error != nil { // Deal with error here
                print("error")
                return
            }else if let listPlaces = listPlaces{
                self.places = listPlaces
                self.agregarImg()
            }
        }
    }
    
    func agregarImg() {
        for index in 0...(places.count-1){
            placesServices.getImagePlace(with: places[index].urlImage!) {
                (img, error) in
                if error != nil { // Deal with error here
                    print("error")
                    return
                }else if let img = img{
                    self.places[index].image = img
                }
               self.collectionViewMain.reloadData()
            }
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewMain.dequeueReusableCell(withReuseIdentifier: "celdaMain", for: indexPath) as! MainCollectionViewCell
        cell.tituloTextField.text = places[indexPath.item].name
        cell.imgPlace.image = places[indexPath.item].image!
        print("para cada imagen",places[indexPath.item].image!)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let item = sender as? UICollectionViewCell,
            let indexPath = collectionViewMain.indexPath(for: item),
            let detailVC = segue.destination as? DetailViewController{
            detailVC.place = places[indexPath.item]
        }
}



}


