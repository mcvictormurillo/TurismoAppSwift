//
//  AlertCustom.swift
//  TurismoApp
//
//  Created by Victor Manuel Murillo on 11/03/19.
//  Copyright © 2019 Victor Manuel Murillo. All rights reserved.
//

import Foundation
import UIKit

class AlertCustom{
    
    
    func alert(controller: UIViewController ,message:String, second:Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.init(red: 255, green: 199, blue: 25, alpha: 1)
        alert.view.tintColor = UIColor.red
        alert.view.alpha = 1
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + second){
            alert.dismiss(animated: true)
        }
    }
}
