//
//  alert.swift
//  NIBM Covid 19
//
//  Created by TM on 9/15/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import Foundation
import UIKit

func showAlert(title: String, text: String){
     let uialert = UIAlertController(title: "Error", message: "Please enter Title message" , preferredStyle: UIAlertController.Style.alert)
    uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
    
//    present(uialert, animated: true, completion: nil)
    
    return uialert
    
}
