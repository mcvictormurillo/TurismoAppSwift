//
//  FavoriteViewController.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 22/02/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, URLSessionDelegate{
    
    var placeManger = PlacesManager()
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
        print("VC FAVORITOS",placeManger.placeCount)
        
        recorrePlaces()
}
    
   
    override func viewWillAppear(_ animated: Bool) {
        //actualizar la lista
        // 1. obtener el lugar para agregar
        //2.actualizar interfaz
        print(" Nuevo count favorites",placeManger.placeCount)
        collectionViewFavorite.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //placeManger.addPlace(objPlace: Place(id: 8989, name: "victor", description: "hola desc", image: UIImage(imageLiteralResourceName: "morro"), geo: "geo", state: 1))
        print(" Nuevo count favorites View did will dispar",placeManger.placeCount)
        collectionViewFavorite.reloadData()
    }
    
    func recorrePlaces(){
        for (index,item) in placeManger.retrievePlaces()!.enumerated(){
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
                self.placeManger.setImageToPlace(img: image, index: index)
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
        return placeManger.placeCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFavorite", for: indexPath) as! FavoriteCell
        cell.namePlace.text = placeManger.getPlace(at: indexPath.item).name
        cell.favoriteImage.image = placeManger.getPlace(at: indexPath.item).image
        cell.delegate = self
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let item = sender as? FavoriteCell,
            let indexPath = collectionViewFavorite.indexPath(for: item),
            let detailVC = segue.destination as? DetailViewController{
            detailVC.place = placeManger.getPlace(at: indexPath.item)
        }
    }
    
    
}

protocol FavoriteViewCellDelegate {
    func delete(cell:FavoriteCell)
}

extension FavoriteViewController: FavoriteViewCellDelegate{
    func delete(cell: FavoriteCell) {
        if let indexPath = collectionViewFavorite?.indexPath(for: cell){
            placeManger.removePlaceFavorite(at: indexPath.item)
            collectionViewFavorite?.deleteItems(at: [indexPath])
        }
        
    }
}
