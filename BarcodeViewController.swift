//
//  BarcodeViewController.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 3/03/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import UIKit
import AVFoundation

class BarcodeViewController: UIViewController {
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureSession: AVCaptureSession = AVCaptureSession()
    var delegate:BarcodeViewControllerDelegate?
    
    @IBOutlet var barcodeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func touchCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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

