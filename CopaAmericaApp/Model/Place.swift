//
//  Place.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 28/02/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import UIKit
internal struct Key {
    static let name = "name"
    static let description = "description"
    static let image = "img"
    static let geo = "geo"
    static let state = "state"
}

struct Place{
    var id:Int
    var name:String
    var description:String
    var image:UIImage?
    var geo:String
    var state:Int
    var urlImage:String?
    
    init(id:Int? = nil,name:String,description:String,image:UIImage?,geo:String, state:Int) {
        self.id = id ?? 0
        self.name = name
        self.description = description
        self.image = image!
        self.geo = geo
        self.state = state
    }
    init(id:Int? = nil,name:String,description:String,image:UIImage?,geo:String, state:Int,urlImage:String?) {
        self.id = id ?? 0
        self.name = name
        self.description = description
        self.image = image!
        self.geo = geo
        self.state = state
        self.urlImage = urlImage
    }
    
    init?(rs:FMResultSet) {
        
        let id = rs.int(forColumn: "id")
        let state = rs.int(forColumn: Key.state)
        let image = UIImage(imageLiteralResourceName: "imgDefault")
        guard let name = rs.string(forColumn: Key.name),
            let description = rs.string(forColumn: Key.description),
            let url = rs.string(forColumn: Key.image),
            let geo = rs.string(forColumn: Key.geo)
        else { return nil }
        self.init(id: Int(id), name: name, description: description, image: image, geo: geo, state: Int(state),urlImage:url)
    }
    
    init(json: [String:Any],urlJson:String){
        self.id = json["id"] as? Int ?? 0
        //self.id = Int(self.id)
        self.name = json["name"] as? String ?? "Anonimo"
        self.description = json["description"] as? String ?? "Anonima"
        self.image = UIImage(imageLiteralResourceName: "imgDefault")
        let urlCompleta = json["img"] as? String ?? ""
        self.urlImage =  urlJson + urlCompleta //
        self.geo = json["cord"] as? String ?? ""
        self.state = 0//json["state"] as? Int ?? 0
        
    }
    
    
}
