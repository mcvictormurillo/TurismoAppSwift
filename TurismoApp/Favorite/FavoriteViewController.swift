

import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, URLSessionDelegate{
  

    @IBOutlet var collectionViewFavorite: UICollectionView!

    var partidosManager:PartidosManager?
    var partidosServices:PartidoServiceProtocol = PartidoService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString)
        
        partidosManager = PartidosManager()
        agregarImg()
    }
    
    
    func agregarImg() {
        if(partidosManager!.partidoCount>0){
            for index in 0...(partidosManager!.partidoCount - 1){
                partidosServices.getImagePlace(with: partidosManager!.getPartido(at: index).urlFlagTeam1!) {
                    (img, error) in
                    if error != nil { // Deal with error here
                        print("error")
                        return
                    }else if let img = img{
                        self.partidosManager!.setImageToPartido(img: img, index: index)
                    }
                    //self.collectionViewFavorite.reloadData()
                }
                
            }
        }
        if(partidosManager!.partidoCount>0){
            for index in 0...(partidosManager!.partidoCount - 1){
                partidosServices.getImagePlace(with: partidosManager!.getPartido(at: index).urlFlagTeam2!) {
                    (img, error) in
                    if error != nil { // Deal with error here
                        print("error")
                        return
                    }else if let img = img{
                        self.partidosManager!.setImageToPartidoImg2(img: img, index: index)
                    }
                    self.collectionViewFavorite.reloadData()
                }
                
            }
        }
        
    }
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return partidosManager!.partidoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionViewFavorite.dequeueReusableCell(withReuseIdentifier: "cellFavorite", for: indexPath) as! FavoriteCell
        cell.team1.text = partidosManager!.getPartido(at: indexPath.item).team1
        cell.team2.text = partidosManager!.getPartido(at: indexPath.item).team2
        cell.score.text = partidosManager!.getPartido(at: indexPath.item).score
        cell.dataMatch.text = partidosManager!.getPartido(at: indexPath.item).dateMatch
        cell.flagTeam1.image = partidosManager!.getPartido(at: indexPath.item).flagTeam1
        cell.flagTeam2.image = partidosManager!.getPartido(at: indexPath.item).flagTeam2
        return cell
    }
    

    
    
    
   
   
    
    
    
}




