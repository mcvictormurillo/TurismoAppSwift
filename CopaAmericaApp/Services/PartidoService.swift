//
//  PlaceService.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 25/03/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import Foundation
import UIKit

class PartidoService:NSObject,URLSessionDelegate,PartidoServiceProtocol{
    
    func cancel() {}
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration,delegate: self, delegateQueue:OperationQueue.main)
    }()
    
    
    func getPlace(with urlServer: String,completionHandler: @escaping ([Partido]?, Error?) -> Void){
        guard let url = URL(string: urlServer)else {return}
        let dataTask = session.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completionHandler(nil, error)
            }
            guard let data = data else { return }
            //print(String(data: data, encoding: .utf8))
            self.parseJSON(data: data,url:urlServer, completionHandler: completionHandler)
        }
        dataTask.resume()
    }
    
    
    private func parseJSON(data: Data,url:String, completionHandler:@escaping ([Partido]?, Error?) -> Void) {
        do{
            guard let json = try  JSONSerialization.jsonObject(with: data, options: .mutableContainers ) as?  [[String:Any]] else{
                print("sin acceso")
                completionHandler(nil, nil)
                return
            }
            //formar un array de lugares con el json
            print("====== JSON ======")
            print(json)
            recorreJson(lista: json, url: url,completionHandler: completionHandler)
            //print(listPlaces)
        }catch let jsonErr as NSError{
            completionHandler(nil, jsonErr)
            return
        }
        
    }
    
    
    func recorreJson(lista:[[String:Any]],url:String,completionHandler: @escaping ([Partido]?,Error?) -> Void){
        var misplaces:[Partido] = []
        for item in lista{
            var placeFind = Partido.init(json: item, urlJson: url)
            //placeFind.image = loadCover(urlImage: placeFind.urlImage!)
            misplaces.append(placeFind)
        }
        completionHandler(misplaces,nil)
    }
    
    
    func  getImagePlace(with urlServer: String,completionHandler: @escaping (UIImage?, Error?) -> Void){
        guard let url = URL(string: urlServer) else {
            print("no funciona la url")
            return}
        var img:UIImage = UIImage(imageLiteralResourceName: "morro")
        let task = session.downloadTask(with: url) { (tempURL, response, error) in
            if let tempURL = tempURL,
                let data = try? Data(contentsOf: tempURL),
                let image = UIImage(data: data) {
                img = image
                print("si funciona",img)
            }
            completionHandler(img,nil)
        }
        
        task.resume()
    }
    
    
    
    
    
    
    
}




protocol PartidoServiceProtocol {
    func getPlace(with urlServer: String,
                  completionHandler: @escaping ([Partido]?, Error?) -> Void)
    
    func cancel()
    
    func getImagePlace(with urlServer: String,
                       completionHandler: @escaping (UIImage?, Error?) -> Void)
}

