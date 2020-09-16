//
//  alert.swift
//  NIBM Covid 19
//
//  Created by TM on 9/17/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import UIKit


func showMainAlert(title: String, text: String) -> UIAlertController{
    let uialert = UIAlertController(title: title, message: text , preferredStyle: UIAlertController.Style.alert)
    uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
//    present(uialert, animated: true, completion: nil)
    return uialert
    
}
