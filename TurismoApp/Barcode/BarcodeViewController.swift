//
//  BarcodeViewController.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 3/03/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//tableCell

import UIKit
import AVFoundation

class BarcodeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var previewLayer: AVCaptureVideoPreviewLayer!
    

    @IBOutlet var tableView: UITableView!
    @IBOutlet var namePlace: UITextField!
    @IBOutlet var descriptio: UITextField!
    @IBOutlet var urlPlace: UITextField!
    var placeManager = PlacesManager()
    var index:Int?
    var captureSession: AVCaptureSession = AVCaptureSession()
    var delegate:BarcodeViewControllerDelegate?
    var sites:[String] = ["Iglesia","Museo","Restaurante","Parque","Otro"]
    
   
    @IBOutlet var barcodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did Load Barcode")
        
        guard let cameraDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            failed();return }
        
        guard let videoInput = try? AVCaptureDeviceInput(device: cameraDevice)
            else {
                failed()
                return}
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput) }
        else {failed();return}
        
        //que queremos hacer
        //Bar code detector
        let metadataOutput = AVCaptureMetadataOutput()
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput) }
        else {failed();return}
        // Customize metadata output
        metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.ean13]
        
        metadataOutput.setMetadataObjectsDelegate( self, queue: DispatchQueue.main)
        captureSession.startRunning()
        
        //Add preview
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.frame
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        view.layer.addSublayer(previewLayer)
       
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numero de sitios",sites.count)
        return sites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel!.text = sites[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 0.5
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.layer.borderWidth = 0
        index = indexPath.item
    }
    
    @IBAction func btnSavePlace(_ sender: Any) {
        
        guard let nombre = namePlace.text, let description = descriptio.text, let url = urlPlace.text else{
            //mostrar la alert
            print("Datos incorrectos")
            return
            
        }
        let id = Int(arc4random_uniform(UInt32(1000)))  //Int(arc4random())
        print("id es:", id)
        let objPlace = Place(id: id, name: nombre, description: description , image: UIImage(imageLiteralResourceName: "imgDefault"), geo: "1.121212,+2.31212", state: 0, urlImage:url )
        
        if(placeManager.addPlaceFavorite(objPlace)){
            navigationController!.popViewController(animated: true)
            //AlertCustom().alert(controller: self, message: " Add to Favorite",second:0.5)
            DataFavorite.actualizar = true
        }else{
            
             AlertCustom().alert(controller: self, message: " No Added to Favorite",second:1.2)
             print("no se agrego place")

        }
        
 
    }
    
    @IBAction func touchCancel(_ sender: UIBarButtonItem) {
        navigationController!.popViewController(animated: true)
    }
    
    func dismissMe() {
        if presentingViewController != nil { // was presented via modal segue
            dismiss(animated: true, completion: nil) } else {
            // was pushed onto navigation stack
            navigationController!.popViewController(animated: true)
        }
    }
    
    
    @IBAction func touchBarcode(_ sender: Any) {
        delegate?.foundBarcode(barcode: barcodeTextField.text!)
        dismiss(animated: true, completion: nil)
    }
    
    func failed() {
        //que mensaje mostrara
        let ac = UIAlertController(title: "Barcode detection not supported", message: "Your device doesn't support barcode detection.", preferredStyle: .alert)
        
        //que accion va a hacer
        let alert = UIAlertAction(title: "OK", style: .default)
        //{(action) in self.dismiss(animated: true, completion: nil) }
        ac.addAction(alert)
        present(ac, animated: true, completion: nil)
        
        
    }
    
    
}

//la clase que envia define el protocolo
protocol BarcodeViewControllerDelegate {
    func foundBarcode(barcode:String)
}

//leemos el barcode y lo pasamos al BookViewController
extension BarcodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        
        if let metadataObject = metadataObjects.first as?
            AVMetadataMachineReadableCodeObject {
            captureSession.stopRunning()
            delegate?.foundBarcode(barcode:
                metadataObject.stringValue!)
            //dismiss(animated: true, completion: nil)
            
        }
        
    }
    //cuando la condicion del guard es nula se va por el else
    //si tiene un valor entonces se dempaqueta y continua
}

