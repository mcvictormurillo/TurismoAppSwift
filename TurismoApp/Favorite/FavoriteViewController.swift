//
//  FavoriteViewController.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 22/02/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, URLSessionDelegate{

    @IBOutlet var collectionViewFavorite: UICollectionView!
    
    let jsonUrlString = "https://api.myjson.com/bins/1admst"
    
    var posicionesServices:PosicionesServiceProtocol = PosicionesService()
    lazy var posiciones:[Posicion] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosiciones()
}
    
    func loadPosiciones() {
        posicionesServices.getPosicion(with: jsonUrlString) {
            (listaPosiciones, error) in
            if error != nil { // Deal with error here
                print("error")
                return
            }else if let listaPosiciones = listaPosiciones{
                print("=======================================")
                print(listaPosiciones)
                self.posiciones = listaPosiciones
                self.agregarImg()
                
            }
        }
    }

    func agregarImg() {
        for index in 0...(posiciones.count-1){
            posicionesServices.getImagePosicion(with: posiciones[index].urlImgPos1) {
                (img, error) in
                if error != nil { // Deal with error here
                    print("error")
                    return
                }else if let img = img{
                    self.posiciones[index].imgPos1 = img
                }
                self.collectionViewFavorite.reloadData()
            }
           
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posiciones.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewFavorite.dequeueReusableCell(withReuseIdentifier: "cellFavorite", for: indexPath) as! FavoriteCell
        cell.nombre.text = "HOLA"//placeManger!.getPlace(at: indexPath.item).name
       
        return cell
    }
    
   
    
    
    
}




