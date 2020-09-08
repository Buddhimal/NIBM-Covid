//
//  SettingsTableViewCell.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 9/6/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width , height: 50))
        view.backgroundColor = UIColor.clear
        
        view.addSubview(yesButton)
        
        return view
    }()
    
    private let yesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("YES", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
//        button.addTarget(self, action: #selector(clickYesButton), for: .touchUpInside)
        
        return button
    }()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
    }

}
