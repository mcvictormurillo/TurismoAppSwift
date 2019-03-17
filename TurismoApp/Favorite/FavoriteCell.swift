//
//  FavoriteCell.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 3/03/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    
    
    @IBOutlet var namePlace: UILabel!
    @IBOutlet var favoriteImage: UIImageView!
    @IBOutlet var deleteButtonBackgroundView: UIVisualEffectView!
    var delegate: FavoriteViewCellDelegate?
    var imageName:String! {
        didSet {
            //favoriteImage.image = UIImage(imageLiteralResourceName: imageName )
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
    
    @IBAction func deleteButton(_ sender: UIButton) {
        delegate?.delete(cell: self)
    }
    
}



