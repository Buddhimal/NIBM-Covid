//
//  UpdateViewController.swift
//  NIBM Covid 19
//
//  Created by TM on 9/12/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Update"
        view.backgroundColor = .white
        configureUI()
        
    }
    
    private func configureUI(){
        
        let createView = UIView()
        createView.translatesAutoresizingMaskIntoConstraints = false
        createView.backgroundColor = .gray
        view.addSubview(createView)
        
        
        let createNotificationView = UIView()
        createNotificationView.translatesAutoresizingMaskIntoConstraints = false
        createNotificationView.backgroundColor = .orange
        //        createNotificationView.isHidden = true
        view.addSubview(createNotificationView)
        
        let newSurveyView = UIView()
        newSurveyView.translatesAutoresizingMaskIntoConstraints = false
        newSurveyView.backgroundColor = .yellow
        view.addSubview(newSurveyView)
        
        
        let updateView = UIView()
        updateView.translatesAutoresizingMaskIntoConstraints = false
        updateView.backgroundColor = .gray
        view.addSubview(updateView)
        
        
        
        NSLayoutConstraint.activate([
            createView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            createView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 5),
            createView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            createView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.06),
            
            
            
            createNotificationView.topAnchor.constraint(equalTo:createView.bottomAnchor, constant: 10),
            createNotificationView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 5),
            createNotificationView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            createNotificationView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.1),
            
            
            
            newSurveyView.topAnchor.constraint(equalTo:createNotificationView.bottomAnchor, constant: 10),
            newSurveyView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 5),
            newSurveyView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            newSurveyView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.1),
            
            updateView.topAnchor.constraint(equalTo:newSurveyView.bottomAnchor, constant: 30),
            updateView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 5),
            updateView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            updateView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.5),

            
            
            
        ])
        
        
    }
    
    
}
