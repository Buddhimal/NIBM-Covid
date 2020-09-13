//
//  NotificationTableViewCell.swift
//  NIBM Covid 19
//
//  Created by Buddhimal Gunasekara on 9/13/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    
    lazy var backView: UIView = {
        
        let view = UIView(frame: CGRect(x: 10, y: 6, width: UIScreen.main.bounds.size.width - 20, height: 110))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var userImage: UIImageView = {
        let userImage = UIImageView(frame: CGRect(x: 4, y: 4, width: 104, height: 104))
        userImage.contentMode = .scaleAspectFill
        userImage.image = #imageLiteral(resourceName: "notification")
        return userImage
    }()
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 116, y: 8, width: UIScreen.main.bounds.size.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    lazy var textLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 116, y: 42, width: UIScreen.main.bounds.size.width - 116, height: 30))
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var dateLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 116, y: 82, width: UIScreen.main.bounds.size.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 12)
        return lbl
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        userImage.layer.cornerRadius = 52
        userImage.clipsToBounds = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        addSubview(backView)
        backView.addSubview(userImage)
        backView.addSubview(titleLbl)
        backView.addSubview(textLbl)
        backView.addSubview(dateLbl)

    }

}
