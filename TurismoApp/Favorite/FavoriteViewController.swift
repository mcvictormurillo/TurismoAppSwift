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
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Agregramos el boton de navegacion editBoton
        navigationItem.leftBarButtonItem = editButtonItem
        //Recuperamos las imagenes de internet
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString)
        //print("View Did Load FAVORITOS")
        placeManger = PlacesManager()
        recorrePlaces()
}
    
   
    override func viewWillAppear(_ animated: Bool) {
        let actualiazar = DataFavorite.actualizar
        if(actualiazar){
            placeManger = PlacesManager()
            recorrePlaces()
            collectionViewFavorite.reloadData()
            DataFavorite.actualizar = false
        }else{
            print("no hay datos por actualizar")
        }
        
    }
    
    
    func recorrePlaces(){
        for (index,item) in placeManger!.places.enumerated(){
            recuperarImagenesInternet(thumnailUrl: item.urlImage!,index: index)
        }
    }
    
    func recuperarImagenesInternet(thumnailUrl:String, index:Int){
        guard let url = URL(string: thumnailUrl) else {return}
        let task = session.downloadTask(with: url) { (tempURL, response, error) in
            if let tempURL = tempURL,
                let data = try? Data(contentsOf: tempURL),
                let image = UIImage(data: data) {
                //print("favorite:",data)
                self.placeManger!.setImageToPlace(img: image, index: index)
                self.collectionViewFavorite.reloadData()
            }
        }
        task.resume()
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


