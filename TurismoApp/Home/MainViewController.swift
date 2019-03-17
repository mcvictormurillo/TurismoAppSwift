//
//  MainViewController.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 17/03/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionViewMain: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: (self.collectionViewMain.frame.size.width - 20)/2 , height: (self.collectionViewMain.frame.size.height)/3)
        layout.minimumInteritemSpacing = 5 //3
        collectionViewMain.collectionViewLayout = layout
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewMain.dequeueReusableCell(withReuseIdentifier: "celdaMain", for: indexPath) as! MainCollectionViewCell
        cell.tituloTextField.text = "Vamos CAPITAN"
        return cell
    }



}
