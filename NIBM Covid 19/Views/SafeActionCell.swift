//
//  SafeActionCell.swift
//  NIBM Covid 19
//
//  Created by Buddhimal Gunasekara on 9/13/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import UIKit

class SafeActionCell: UICollectionViewCell {
    
    let symptomsImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "covid_symptoms") )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let questionTextView: UITextView = {
        
        let question = UITextView()
        let attributedText = NSMutableAttributedString(string:  "Are You having any symptoms above?", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)])
        question.attributedText = attributedText
        question.textAlignment = .center
        question.isEditable = false
        question.isScrollEnabled = false
        question.translatesAutoresizingMaskIntoConstraints = false
        return question
    }()
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
//        setButtonControl()
//        backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        addSubview(questionTextView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        topImageContainerView.addSubview(symptomsImageView)
        symptomsImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        symptomsImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        symptomsImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.8).isActive = true
        
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        questionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor,constant: 80).isActive = true
        questionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        questionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        questionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    
}
