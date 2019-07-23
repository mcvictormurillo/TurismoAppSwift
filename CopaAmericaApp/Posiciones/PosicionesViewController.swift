

import UIKit

class PosicionesViewController:  UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,URLSessionDelegate {
    
    @IBOutlet var collectionPosiciones: UICollectionView!
    let jsonUrlString = "https://api.myjson.com/bins/1admst"
    var posicionesServices:PosicionesServiceProtocol = PosicionesService()
    lazy var posiciones:[Posicion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosiciones()

    }
    
    func loadPosiciones() {
        posicionesServices.getPosicion(with: jsonUrlString) {
            (listaPosiciones, error) in
            if error != nil { // Deal with error here
                print("error")
                return
            }else if let listaPosiciones = listaPosiciones{
                //print("=======================================")
                //print(listaPosiciones)
                self.posiciones = listaPosiciones
                self.agregarImg()
            }
        }
    }
    
    
    func agregarImg() {
        
        for index in 0...(posiciones.count-1){
            posicionesServices.getImagePosicion(with: posiciones[index].urlImgPos1) {
                (img, error) in
                if error != nil { // Deal with error here
                    print("error")
                    return
                }else if let img = img{
                    self.posiciones[index].imgPos1 = img
                }
                self.collectionPosiciones.reloadData()
            }
        }
        for index in 0...(posiciones.count-1){
            posicionesServices.getImagePosicion(with: posiciones[index].urlImgPos2) {
                (img, error) in
                if error != nil { // Deal with error here
                    print("error")
                    return
                }else if let img = img{
                    self.posiciones[index].imgPos2 = img
                }
                self.collectionPosiciones.reloadData()
            }
        }
        for index in 0...(posiciones.count-1){
            posicionesServices.getImagePosicion(with: posiciones[index].urlImgPos3) {
                (img, error) in
                if error != nil { // Deal with error here
                    print("error")
                    return
                }else if let img = img{
                    self.posiciones[index].imgPos3 = img
                }
                self.collectionPosiciones.reloadData()
            }
        }
        for index in 0...(posiciones.count-1){
            posicionesServices.getImagePosicion(with: posiciones[index].urlImgPos4) {
                (img, error) in
                if error != nil { // Deal with error here
                    print("error")
                    return
                }else if let img = img{
                    self.posiciones[index].imgPos4 = img
                }
                self.collectionPosiciones.reloadData()
            }
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posiciones.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionPosiciones.dequeueReusableCell(withReuseIdentifier: "cellPosicion", for: indexPath) as! PosicionCollectionViewCell
        cell.nombre.text = posiciones[indexPath.item].nameGroup
        cell.position1.text = posiciones[indexPath.item].position1
        cell.position2.text = posiciones[indexPath.item].position2
        cell.position3.text = posiciones[indexPath.item].position3
        cell.position4.text = posiciones[indexPath.item].position4
        cell.namePosition1.text = posiciones[indexPath.item].namePosition1
        cell.namePosition2.text = posiciones[indexPath.item].namePosition2
        cell.namePosition3.text = posiciones[indexPath.item].namePosition3
        cell.namePosition4.text = posiciones[indexPath.item].namePosition4
        cell.pj1.text = posiciones[indexPath.item].pj1
        cell.pj2.text = posiciones[indexPath.item].pj2
        cell.pj3.text = posiciones[indexPath.item].pj3
        cell.pj4.text = posiciones[indexPath.item].pj4
        cell.goals1.text = posiciones[indexPath.item].goals1
        cell.goals2.text = posiciones[indexPath.item].goals2
        cell.goals3.text = posiciones[indexPath.item].goals3
        cell.goals4.text = posiciones[indexPath.item].goals4
        cell.difGoal1.text = posiciones[indexPath.item].difGoal1
        cell.difGoal2.text = posiciones[indexPath.item].difGoal2
        cell.difGoal3.text = posiciones[indexPath.item].difGoal3
        cell.difGoal4.text = posiciones[indexPath.item].difGoal4
        cell.imgPos1.image = posiciones[indexPath.item].imgPos1
        cell.imgPos2.image = posiciones[indexPath.item].imgPos2
        cell.imgPos3.image = posiciones[indexPath.item].imgPos3
        cell.imgPos4.image = posiciones[indexPath.item].imgPos4
        return cell
    }
    


}
