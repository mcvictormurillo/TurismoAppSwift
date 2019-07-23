

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

class PartidosManager{
    
    lazy var partidos:[Partido] = self.loadPartidos()
    var partidoCount:Int{
        return partidos.count
    }
    
    
    
    //obtener un place de la lista de places
    func getPartido(at index:Int)->Partido {
        return partidos[index]
    }
    
    func setImageToPartido(img:UIImage, index:Int){
        partidos[index].flagTeam1 = img
    }
    func setImageToPartidoImg2(img:UIImage, index:Int){
        partidos[index].flagTeam2 = img
    }
    
    //cargar lista de places
    private func loadPartidos()->[Partido] {
        return retrievePartidos() ?? []
    }
    
    func addPartido(objPartido:Partido){
        partidos.append(objPartido)
        print("Partido Manger tiene ",partidoCount)
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
    func retrievePartidos() -> [Partido]? {
        print("metodo retrievePartido")
        guard let db = getOpenDB() else {
            print("error en la bd")
            return nil }
        var partidos:[Partido] = []
        do {
            print("leyendo bd")
            let rs = try db.executeQuery(
                "SELECT * FROM places", values: nil)
            while rs.next() {
                if let partido = Partido(rs: rs) {
                    partidos.append(partido)
                    print("Partido")
                    print(partido)
                }
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        db.close()
        
        return partidos
    }
    
    
    //guardar en la base de datos que es un INOUT  porque modificamos un atributo del argumento que llega a la funcion, para que no sea inmutable el & vuelve el argumento mutable
    func SQLAddPlace(partido:inout Partido)->Bool {
        guard let db = getOpenDB() else { return false }
        do {
            try db.executeUpdate("insert into places (id, team1, team2, score, dateMatch, urlFlagTeam1,urlFlagTeam2) values(?, ?, ?, ?, ?, ?,?)", values: [10, partido.team1, partido.team2,partido.score,partido.dateMatch,partido.urlFlagTeam1, partido.urlFlagTeam2]
            )
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        db.close()
        return true
    }
    
    
    
    
    
}

