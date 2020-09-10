//
//  SurveyFifthViewController.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 9/2/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class SurveyFifthViewController: UIViewController {

    
    //    MARK: Configurations
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    //    MARK: UI Components
    
    let symptomsImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "recover") )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let questionTextView: UITextView = {
        
        let question = UITextView()
        let attributedText = NSMutableAttributedString(string:  "All Compleated!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)])
        
        question.attributedText = attributedText
        question.textAlignment = .center
        question.isEditable = false
        question.isScrollEnabled = false
        question.translatesAutoresizingMaskIntoConstraints = false
        return question
    }()
    
    
    private let finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("FINISH", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.indigo, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(clickFinishButton), for: .touchUpInside)
        
        return button
    }()
    
    //    MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(questionTextView)
        setupLayout()
        setButtonControl()
        
    }
    
    
    //    MARK: Controls
    
    private func setButtonControl(){
        
        let bottomControlStackView = UIStackView(arrangedSubviews: [finishButton])
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlStackView)
        
        NSLayoutConstraint.activate([
            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    private func setupLayout(){
        
        let topImageContainerView = UIView()
        view.addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        topImageContainerView.addSubview(symptomsImageView)
        symptomsImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        symptomsImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        symptomsImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.6).isActive = true
        
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        questionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor,constant: 80).isActive = true
        questionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        questionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        questionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    // MARK: - Functions
        
        func handleSurveyAction() {
            let vc = SurveyFirstViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
        @objc func clickFinishButton() {
            handleSurveyAction()
        }

    
}
