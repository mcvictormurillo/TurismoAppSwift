//
//  CollectionViewCellFavorite.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 22/02/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import UIKit

class CollectionViewCellFavorite : UICollectionViewCell {

    @IBOutlet var deleteButtonBackgroundView: UIButton!
    @IBOutlet var favoriteImage: UIImageView!
    @IBOutlet var namePlace: UILabel!
     var delegate: FavoriteCellDelegate?
    var imageName:String! {
        didSet {
            favoriteImage.image = UIImage(imageLiteralResourceName: imageName )
            deleteButtonBackgroundView.layer.cornerRadius = deleteButtonBackgroundView.bounds.width/2.0
            deleteButtonBackgroundView.layer.masksToBounds = true
            deleteButtonBackgroundView.isHidden = !isEditing //lo ocultamos
        }
    }
    
    var isEditing :Bool = false {
        didSet{
            deleteButtonBackgroundView.isHidden = !isEditing
            
        }
    }

    @IBAction func deleteButtonDidTap(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
}

protocol FavoriteCellDelegate {
    func delete(cell:CollectionViewCellFavorite)
}
