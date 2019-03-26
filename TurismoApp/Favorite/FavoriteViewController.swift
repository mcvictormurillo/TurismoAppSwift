//
//  FavoriteViewController.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 22/02/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, URLSessionDelegate{
    
    var placeManger:PlacesManager?
    @IBOutlet var collectionViewFavorite: UICollectionView!
    var placesServices:PlaceServiceProtocol = PlaceService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Agregramos el boton de navegacion editBoton
        navigationItem.leftBarButtonItem = editButtonItem
        //Recuperamos las imagenes de internet
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString)
        placeManger = PlacesManager()
        agregarImg()
}
    
   
    override func viewWillAppear(_ animated: Bool) {
        let actualiazar = DataFavorite.actualizar
        if(actualiazar){
            placeManger = PlacesManager()
            agregarImg()
            collectionViewFavorite.reloadData()
            DataFavorite.actualizar = false
        }else{
            print("no hay datos por actualizar")
        }
        
    }
    
    
  
    func agregarImg() {
        if(placeManger!.placeCount>0){
            for index in 0...(placeManger!.placeCount - 1){
                placesServices.getImagePlace(with: placeManger!.getPlace(at: index).urlImage!) {
                    (img, error) in
                    if error != nil { // Deal with error here
                        print("error")
                        return
                    }else if let img = img{
                        self.placeManger!.setImageToPlace(img: img, index: index)
                    }
                    self.collectionViewFavorite.reloadData()
                }
                
            }
        }
        
    }
    

    
    //Eliminar items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated )
        if let indexPaths = collectionViewFavorite?.indexPathsForVisibleItems{
            for indexPath in indexPaths{
                if let cell = collectionViewFavorite.cellForItem(at: indexPath) as? FavoriteCell{
                    cell.isEditing = editing
                    
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeManger!.placeCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFavorite", for: indexPath) as! FavoriteCell
        cell.namePlace.text = placeManger!.getPlace(at: indexPath.item).name
        cell.favoriteImage.image = placeManger!.getPlace(at: indexPath.item).image
        print("favoritos")
        print(placeManger!.getPlace(at: indexPath.item).image)
        cell.delegate = self
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let item = sender as? FavoriteCell,
            let indexPath = collectionViewFavorite.indexPath(for: item),
            let detailVC = segue.destination as? DetailViewController{
            detailVC.place = placeManger!.getPlace(at: indexPath.item)
            
        }
    }
    
    
}



protocol FavoriteViewCellDelegate {
    func delete(cell:FavoriteCell)
}

extension FavoriteViewController: FavoriteViewCellDelegate{
    func delete(cell: FavoriteCell) {
        if let indexPath = collectionViewFavorite?.indexPath(for: cell){
            let eliminado = placeManger!.removePlaceFavorite(at: indexPath.item)
            if(eliminado){
                print("ELIMINADO DE FAVORITOS")
            }else{
                print("FALLO EN ELIMINAR")
            }
            collectionViewFavorite?.deleteItems(at: [indexPath])
        }
        
    }
}


