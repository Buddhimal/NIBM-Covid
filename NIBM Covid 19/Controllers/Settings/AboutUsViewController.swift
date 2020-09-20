//
//  AboutUsViewController.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 9/5/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import KeychainSwift

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Contact Us / About us"
        
        let keychain = KeychainSwift()
        print("keychainLabel")
//        keychain.accessGroup = "123ABCXYZ.iOSAppTemplates"
        let userName = keychain.get("userName")
        let password = keychain.get("password")
        
        
        let keychainLabel = "userName = \(userName) password = \(password)"
        print(keychainLabel)
        
    }
    
}
