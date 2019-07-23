

import Foundation
import UIKit

internal struct estructuraPosicion {

    static let nameGroup = "nameGroup"
    static let position1 = "position1"
    static let position2 = "position2"
    static let position3 = "position3"
    static let position4 = "position4"
    static let namePosition1 = "namePosition1"
    static let namePosition2 = "namePosition2"
    static let namePosition3 = "namePosition3"
    static let namePosition4 = "namePosition4"
    static let goals1 = "goals1"
    static let goals2 = "goals2"
    static let goals3 = "goals3"
    static let goals4 = "goals4"
    static let difGoal1 = "difGoal1"
    static let difGoal2 = "difGoal2"
    static let difGoal3 = "difGoal3"
    static let difGoal4 = "difGoal4"
    static let pts1 = "pts1"
    static let pts2 = "pts2"
    static let pts3 = "pts3"
    static let pts4 = "pts4"
    static let pj1 = "pj1"
    static let pj2 = "pj2"
    static let pj3 = "pj3"
    static let pj4 = "pj4"
    static let imgPos1 = "imgPos1"
    static let imgPos2 = "imgPos2"
    static let imgPos3 = "imgPos3"
    static let imgPos4 = "imgPos4"
    
}

struct Posicion{
    var nameGroup:String
    var position1:String
    var position2:String
    var position3:String
    var position4:String
    var namePosition1:String
    var namePosition2:String
    var namePosition3:String
    var namePosition4:String
    var goals1:String
    var goals2:String
    var goals3:String
    var goals4:String
    var difGoal1:String
    var difGoal2:String
    var difGoal3:String
    var difGoal4:String
    var pts1:String
    var pts2:String
    var pts3:String
    var pts4:String
    var pj1:String
    var pj2:String
    var pj3:String
    var pj4:String
    var urlImgPos1:String
    var urlImgPos2:String
    var urlImgPos3:String
    var urlImgPos4:String
    var imgPos1:UIImage
    var imgPos2:UIImage
    var imgPos3:UIImage
    var imgPos4:UIImage
   
    
    
    init(nameGroup:String,
         position1:String,position2:String,position3:String,position4:String,
         namePosition1:String,namePosition2:String,namePosition3:String,namePosition4:String,
         goals1:String,goals2:String,goals3:String,goals4:String,
         difGoal1:String,difGoal2:String,difGoal3:String,difGoal4:String,
         pts1:String,pts2:String,pts3:String,pts4:String,
         pj1:String,pj2:String,pj3:String,pj4:String,
         urlImgPos1:String,urlImgPos2:String,urlImgPos3:String,urlImgPos4:String,
         imgPos1:UIImage?,imgPos2:UIImage?,imgPos3:UIImage?,imgPos4:UIImage?) {
        
        self.nameGroup = nameGroup
        self.position1 = position1
        self.position2 = position2
        self.position3 = position3
        self.position4 = position4
        self.namePosition1 = namePosition1
        self.namePosition2 = namePosition2
        self.namePosition3 = namePosition3
        self.namePosition4 = namePosition4
        self.goals1 = goals1
        self.goals2 = goals2
        self.goals3 = goals3
        self.goals4 = goals4
        self.difGoal1 = difGoal1
        self.difGoal2 = difGoal2
        self.difGoal3 = difGoal3
        self.difGoal4 = difGoal4
        self.pts1 = pts1
        self.pts2 = pts2
        self.pts3 = pts3
        self.pts4 = pts4
        self.pj1 = pj1
        self.pj2 = pj2
        self.pj3 = pj3
        self.pj4 = pj4
        self.urlImgPos1 = urlImgPos1
        self.urlImgPos2 = urlImgPos2
        self.urlImgPos3 = urlImgPos3
        self.urlImgPos4 = urlImgPos4
        self.imgPos1 = imgPos1!
        self.imgPos2 = imgPos2!
        self.imgPos3 = imgPos3!
        self.imgPos4 = imgPos4!
    }
    
    
    init(json: [String:Any],urlJson:String){
        self.nameGroup = json["nameGroup"] as? String ?? "Anonimo"
        self.position1 = json["position1"] as? String ?? "Anonimo"
        self.position2 = json["position2"] as? String ?? "Anonimo"
        self.position3 = json["position3"] as? String ?? "Anonimo"
        self.position4 = json["position4"] as? String ?? "Anonimo"
        self.namePosition1 = json["namePosition1"] as? String ?? "Anonimo"
        self.namePosition2 = json["namePosition2"] as? String ?? "Anonimo"
        self.namePosition3 = json["namePosition3"] as? String ?? "Anonimo"
        self.namePosition4 = json["namePosition4"] as? String ?? "Anonimo"
        self.goals1 = json["goals1"] as? String ?? "Anonimo"
        self.goals2 = json["goals2"] as? String ?? "Anonimo"
        self.goals3 = json["goals3"] as? String ?? "Anonimo"
        self.goals4 = json["goals4"] as? String ?? "Anonimo"
        self.difGoal1 = json["difGoal1"] as? String ?? "Anonimo"
        self.difGoal2 = json["difGoal2"] as? String ?? "Anonimo"
        self.difGoal3 = json["difGoal3"] as? String ?? "Anonimo"
        self.difGoal4 = json["difGoal4"] as? String ?? "Anonimo"
        self.pts1 = json["pts1"] as? String ?? "Anonimo"
        self.pts2 = json["pts2"] as? String ?? "Anonimo"
        self.pts3 = json["pts3"] as? String ?? "Anonimo"
        self.pts4 = json["pts4"] as? String ?? "Anonimo"
        self.pj1 = json["pj1"] as? String ?? "Anonimo"
        self.pj2 = json["pj2"] as? String ?? "Anonimo"
        self.pj3 = json["pj3"] as? String ?? "Anonimo"
        self.pj4 = json["pj4"] as? String ?? "Anonimo"
        self.urlImgPos1 = json["imgPos1"] as? String ?? "Anonimo"
        self.urlImgPos2 = json["imgPos2"] as? String ?? "Anonimo"
        self.urlImgPos3 = json["imgPos3"] as? String ?? "Anonimo"
        self.urlImgPos4 = json["imgPos4"] as? String ?? "Anonimo"
        self.imgPos1 = UIImage(imageLiteralResourceName: "imgDefault")
        self.imgPos2 = UIImage(imageLiteralResourceName: "imgDefault")
        self.imgPos3 = UIImage(imageLiteralResourceName: "imgDefault")
        self.imgPos4 = UIImage(imageLiteralResourceName: "imgDefault")
        
       
    
    }
    
    
}

