//
//  PruebaViewController.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 17/03/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import UIKit

class PruebaViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet var collectionList: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionList.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! PruebaCollectionViewCell
        
        cell.labelText.text = "hola mundo"
        
        return cell
    }

 

}
