//
//  Partido.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 21/07/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import Foundation
import UIKit
internal struct estructura {
    static let team1 = "team1"
    static let team2 = "team2"
    static let score = "score"
    static let dateMatch = "dateMatch"
    static let urlFlagTeam1 = "urlFlagTeam1"
    static let urlFlagTeam2 = "urlFlagTeam2"
}

struct Partido{
    var team1:String
    var team2:String
    var score:String
    var dateMatch:String
    var flagTeam1:UIImage
    var flagTeam2:UIImage
    var urlFlagTeam1:String?
    var urlFlagTeam2:String?

    
    init(team1:String,team2:String,score:String,
         dateMatch:String,flagTeam1:UIImage?,flagTeam2:UIImage?,
         urlFlagTeam1:String?, urlFlagTeam2:String?) {
        self.team1 = team1
        self.team2 = team2
        self.score = score
        self.dateMatch = dateMatch
        self.flagTeam1 = flagTeam1!
        self.flagTeam2 = flagTeam2!
        self.urlFlagTeam1 = urlFlagTeam1
        self.urlFlagTeam2 = urlFlagTeam2
    }
   
    init?(rs:FMResultSet) {
        
        //let id = rs.int(forColumn: "id")
        let team1 = rs.string(forColumn: estructura.team1)
        let team2 = rs.string(forColumn: estructura.team2)
        let score = rs.string(forColumn: estructura.score)
        let dateMatch = rs.string(forColumn: estructura.dateMatch)
        let urlFlagTeam1 = rs.string(forColumn: estructura.urlFlagTeam1)
        let urlFlagTeam2 = rs.string(forColumn: estructura.urlFlagTeam2)
        let image = UIImage(imageLiteralResourceName: "imgDefault")
        self.init(team1: team1!, team2: team2!, score: score!, dateMatch: dateMatch!, flagTeam1: image, flagTeam2: image, urlFlagTeam1: urlFlagTeam1!, urlFlagTeam2: urlFlagTeam2!)
      
    }
    
    
    init(json: [String:Any],urlJson:String){
        self.team1 = json["team1"] as? String ?? "Equipo 1"
        self.team2 = json["team2"] as? String ?? "Equipo 2"
        self.score = json["score"] as? String ?? "Resultado"
        self.dateMatch = json["dateMatch"] as? String ?? "Fecha"
        self.flagTeam1 = UIImage(imageLiteralResourceName: "imgDefault")
        self.flagTeam2 = UIImage(imageLiteralResourceName: "imgDefault")
        self.urlFlagTeam1 = json["flagTeam1"] as? String ?? "www"
        self.urlFlagTeam2 = json["flagTeam2"] as? String ?? "www"
    }
    
    
}
