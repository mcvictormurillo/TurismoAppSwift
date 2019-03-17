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
    let jsonUrlString = "https://gist.githubusercontent.com/mcvictormurillo/9831d96513c9eaabdb37ba8ec8ba5963/raw/2c2c431c0473c8a2f9606ea03590a7cb45108f7d/place.json"
    
    lazy var places:[Place] = []
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
    }()
    
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
    
    func loadPlaces(){
        guard let url:URL = URL(string: jsonUrlString) else{
            print("error en la url")
            return
        }
        session.dataTask(with: url){ (data,response,err) in
            guard let data = data else{return}
            do{
                guard let json = try  JSONSerialization.jsonObject(with: data, options: .mutableContainers ) as?  [[String:Any]] else{print("sin acceso");return}
                self.recorreJson(lista: json)
                
            }catch let jsonErr{
                print("Error serialiazing json:",jsonErr)
            }
            }.resume()
    }
    
    func recorreJson(lista:[[String:Any]]){
        for (index,item) in lista.enumerated() {
         let placeFind = Place.init(json: item, urlJson: jsonUrlString)
         self.places.append(placeFind)
         self.loadImage(thumnailUrl: placeFind.urlImage! ,idPlace: index)
         print("imagen",index, "lugar", placeFind.urlImage!)
         }
         print("numero de lugares", places.count)
       
    }

    func loadImage(thumnailUrl:String, idPlace:Int) {
        guard let url = URL(string: thumnailUrl)else{return}
        let task = session.downloadTask(with: url) { (tempURL, response, error) in
            if let tempURL = tempURL,
                let data = try? Data(contentsOf: tempURL),
                let image = UIImage(data: data) {
                print(data)
                self.places[idPlace].image = image
                //print(self.places[idPlace].image)
                self.collectionViewMain.reloadData()
                
            }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewMain.dequeueReusableCell(withReuseIdentifier: "celdaMain", for: indexPath) as! MainCollectionViewCell
        cell.tituloTextField.text = places[indexPath.item].name
        cell.imgPlace.image = places[indexPath.item].image
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let item = sender as? UICollectionViewCell,
            let indexPath = collectionViewMain.indexPath(for: item),
            let detailVC = segue.destination as? DetailViewController{
            detailVC.place = places[indexPath.item]
            //print(places[indexPath.item])
        }
}



}
