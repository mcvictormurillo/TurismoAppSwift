
import UIKit

class MainViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,URLSessionDelegate {

    @IBOutlet var collectionViewMain: UICollectionView!
    @IBOutlet var floatButtonScanner: UIButton!
    let jsonUrlString = "https://api.myjson.com/bins/gaenp"
    
    var placesServices:PartidoServiceProtocol = PartidoService()
    lazy var places:[Partido] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatButtonScanner.layer.cornerRadius = floatButtonScanner.frame.height/2 
        loadPlaces()
}
    
    func loadPlaces() {
        placesServices.getPlace(with: jsonUrlString) {
            (listPlaces, error) in
            if error != nil { // Deal with error here
                print("error")
                return
            }else if let listPlaces = listPlaces{
                //print("=======================================")
                //print(listPlaces)
                self.places = listPlaces
                self.agregarImg()
            }
        }
    }
    
    func agregarImg() {
        for index in 0...(places.count-1){
            placesServices.getImagePlace(with: places[index].urlFlagTeam1!) {
                (img, error) in
                if error != nil { // Deal with error here
                    print("error")
                    return
                }else if let img = img{
                    self.places[index].flagTeam1 = img
                }
               //self.collectionViewMain.reloadData()
            }
            placesServices.getImagePlace(with: places[index].urlFlagTeam2!) {
                (img, error) in
                if error != nil { // Deal with error here
                    print("error")
                    return
                }else if let img = img{
                    self.places[index].flagTeam2 = img
                }
                self.collectionViewMain.reloadData()
            }
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewMain.dequeueReusableCell(withReuseIdentifier: "celdaMain", for: indexPath) as! MainCollectionViewCell
        cell.team1.text = places[indexPath.item].team1
        cell.team2.text = places[indexPath.item].team2
        cell.score.text = places[indexPath.item].score
        cell.imgTeam1.image = places[indexPath.item].flagTeam1
        cell.imgTeam2.image = places[indexPath.item].flagTeam2
        print("para cada imagen",places[indexPath.item].flagTeam1)
        return cell
    }
    
    
    



}


