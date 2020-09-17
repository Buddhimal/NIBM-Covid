//
//  SurveyResultCell.swift
//  NIBM Covid 19
//
//  Created by Buddhimal Gunasekara on 9/18/20.
//  Copyright © 2020 nibm. All rights reserved.
//
import UIKit

class SurveyResultCell: UITableViewCell {
    
    
    lazy var backView: UIView = {
        
        let view = UIView(frame: CGRect(x: 10, y: 6, width: UIScreen.main.bounds.size.width - 20, height: 200))
        view.backgroundColor = UIColor.white
        return view
    }()
        
    lazy var nameLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 10, y: 8, width: UIScreen.main.bounds.size.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    lazy var q1Lbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 10, y: 40, width: UIScreen.main.bounds.size.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.text = "Qustion One: "
        return lbl
    }()
    
    lazy var q1Text: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 160, y: 40, width: UIScreen.main.bounds.size.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.text = "YES"
        return lbl
    }()
    
    lazy var q2Lbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 10, y: 70, width: UIScreen.main.bounds.size.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.text = "Qustion Two: "

        return lbl
    }()
    
    lazy var q2Text: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 160, y: 70, width: UIScreen.main.bounds.size.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.text = "YES"
        return lbl
    }()


    lazy var q3Lbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 10, y: 100, width: UIScreen.main.bounds.size.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.text = "Qustion Three: "

        return lbl
    }()
    
    lazy var q3Text: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 160, y: 100, width: UIScreen.main.bounds.size.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.text = "YES"
        return lbl
    }()


    lazy var q4Lbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 10, y: 130, width: UIScreen.main.bounds.size.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.text = "Qustion Four: "
        return lbl
    }()
    
    lazy var q4Text: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 160, y: 130, width: UIScreen.main.bounds.size.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.text = "YES"
        return lbl
    }()


    
    lazy var dateLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 10, y: 170, width: UIScreen.main.bounds.size.width - 116, height: 30))
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
        backView.clipsToBounds = true    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        addSubview(backView)
        backView.addSubview(nameLbl)
        backView.addSubview(q1Lbl)
        backView.addSubview(q1Text)
        backView.addSubview(q2Lbl)
        backView.addSubview(q2Text)
        backView.addSubview(q3Lbl)
        backView.addSubview(q3Text)
        backView.addSubview(q4Lbl)
        backView.addSubview(q4Text)
        backView.addSubview(dateLbl)

    }

}
