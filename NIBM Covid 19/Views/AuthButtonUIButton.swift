//
//  AuthButtonUIButton.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 8/29/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class AuthButtonUIButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(UIColor(white: 1, alpha: 1), for: .normal)
        backgroundColor = UIColor.rgb(red: 156, green: 68, blue: 109)
        layer.cornerRadius = 5
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("AuthButtonUIButton coder error")
    }


}
