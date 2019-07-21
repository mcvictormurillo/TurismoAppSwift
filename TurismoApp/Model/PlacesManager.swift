//
//  PlacesManager.swift
//  TurismoApp
//  Created by Victor Manuel Murillo on 9/03/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import Foundation
import UIKit

// VARIABLES GLOBALES
private var appSupportDirectory:URL = {
    let url = FileManager().urls(for:.applicationSupportDirectory,in: .userDomainMask).first!
    if !FileManager().fileExists(atPath: url.path) {
        do {
            try FileManager().createDirectory(at: url,
                                              withIntermediateDirectories: false)
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    return url
}()

private var placesFile:URL = {
    let filePath = appSupportDirectory.appendingPathComponent("Places").appendingPathExtension("db")
    print(filePath)
    if !FileManager().fileExists(atPath: filePath.path) {
        if let bundleFilePath = Bundle.main.resourceURL?.appendingPathComponent("Places").appendingPathExtension("db") {
            do {
                try FileManager().copyItem(at: bundleFilePath, to: filePath)
            } catch let error as NSError {
                //fingers crossed
                print("\(error.localizedDescription)")
            }
        }
    }
    return filePath
}()

class PlacesManager{
    
    lazy var places:[Place] = self.loadPlaces()
    var placeCount:Int{
        return places.count
    }
    
   
    
    //obtener un place de la lista de places
    func getPlace(at index:Int)->Place {
        return places[index]
    }
    
    func setImageToPlace(img:UIImage, index:Int){
        places[index].image = img
    }
    
    //cargar lista de places
    private func loadPlaces()->[Place] {
        return retrievePlaces() ?? []
    }
    
    func addPlace(objPlace:Place){
        places.append(objPlace)
        print("Place Manger tiene ",placeCount)
    }
    //agregar a favoritos
    func addPlaceFavorite(_ place:Place)->Bool {
        var place = place
        if SQLAddPlace(place: &place){
            places.append(place)
            print("se agrego los places")
            print("Place Manger tiene ",placeCount)
            return true
        }else{
            return false
        }
    
    }
    
    //eliminar de favoritos
    func removePlaceFavorite(at index:Int)->Bool{
        let placeToRemove = places.remove(at: index)
        return SQLRemovePlace(place: placeToRemove)
    }
    
    //abrir BD
    func getOpenDB()->FMDatabase? {
        let db = FMDatabase(path: placesFile.path)
        guard db.open() else {
            print("Unable to open database")
            return nil
        }
        return db
    }
    
    //consultar de la base de datos
    func retrievePlaces() -> [Place]? {
        print("metodo retrievePlaces")
        guard let db = getOpenDB() else {
            print("error en la bd")
            return nil }
        var places:[Place] = []
        do {
            print("leyendo bd")
            let rs = try db.executeQuery(
                "SELECT * FROM places", values: nil)
            while rs.next() {
                if let place = Place(rs: rs) {
                    places.append(place)
                }
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        db.close()
        return places
    }
    
    
    //guardar en la base de datos que es un INOUT  porque modificamos un atributo del argumento que llega a la funcion, para que no sea inmutable el & vuelve el argumento mutable
    func SQLAddPlace(place:inout Place)->Bool {
        guard let db = getOpenDB() else { return false }
        do {
            try db.executeUpdate("insert into places (id, name, description, geo, img, state) values(?, ?, ?, ?, ?, ?)", values: [place.id, place.name, place.description, place.geo, place.urlImage!,1]
            )
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        db.close()
        return true
    }
    
    
    
    
    //remover un places de la bd, es decir de fvaoritos
    func SQLRemovePlace(place:Place)->Bool {
        var bandera = false
        guard let db = getOpenDB() else { return false}
        do {
            try db.executeUpdate(
                "delete from places where id = ?",
                values: [place.id]
                
            )
            bandera = true
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        db.close()
        return bandera
    }
    
    //actualizar
    func SQLUpdateBook(place:Place) {
        guard let db = getOpenDB() else { return }
        do {
            try db.executeUpdate("update places SET name = ?, description = ?, geo = ?, img = ?, state = ? WHERE id = ?", values: [place.id, place.name, place.description, place.geo, place.image! as Any,place.state]
            )
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        db.close()
    }
    
    
}
