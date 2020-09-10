//
//  SurveyFirstViewController.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 9/1/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SurveyFirstViewController: UIViewController {
    
    
    //    MARK: Configurations
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        //        navigationController?.navigationBar.barStyle = .black
    }
    
    //    MARK: UI Components
    
    let symptomsImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "covid_symptoms") )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let questionTextView: UITextView = {
        
        let question = UITextView()
        let attributedText = NSMutableAttributedString(string:  "Are You having any symptoms above?", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)])
        
        //        attributedText.append(NSMutableAttributedString(string: "\n\n\nhello im small font", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray ]))
        
        question.attributedText = attributedText
        
        //        question.text = "Are You having any symptoms above?"
        //        question.font = UIFont.boldSystemFont(ofSize: 18)
        //        question.font = UIFont(name: "Avenir-Light", size: 16)
        question.textAlignment = .center
        question.isEditable = false
        question.isScrollEnabled = false
        question.translatesAutoresizingMaskIntoConstraints = false
        return question
    }()
    
    
    private let yesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("YES", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.indigo, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(clickYesButton), for: .touchUpInside)
        
        return button
    }()
    
    
    private let noButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NOPE", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.indigo, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(clickNoButton), for: .touchUpInside)
        
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 4
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .gray
        
        
        return pc
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
        //        view.addSubview(yesButton)
        //        noButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        //        yesButton.backgroundColor = .red
        
        //        let yellowView = UIView()
        //        yellowView.backgroundColor = .yellow
        //
        //        let blueView = UIView()
        //        blueView.backgroundColor = .blue
        
        let bottomControlStackView = UIStackView(arrangedSubviews: [yesButton,pageControl,noButton])
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlStackView.distribution = .fillEqually
        //        bottomControlStackView.axis = .vertical
        
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
        //        topImageContainerView.backgroundColor = .blue
        view.addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        topImageContainerView.addSubview(symptomsImageView)
        symptomsImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        symptomsImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        //        symptomsImageView.heightAnchor.constraint(equalTo: topImageContainerView, multiplier: 0.6).isActive = true
        symptomsImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.8).isActive = true
        //        symptomsImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        questionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor,constant: 80).isActive = true
        questionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        questionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        questionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    
    
    // MARK: - Functions
    
    func handleSurveyAction(action: Bool? = false) {
        
        var vc = UIViewController()
        let user = Auth.auth().currentUser;
        
        if (user != nil) {
            
            guard let userId = user?.uid else { return }
            
            let values = [
                "surveyOne": action ??  false
                ] as [String : Any]
            
            Database.database().reference().child("survey").child(userId).updateChildValues(values) { (error, ref) in
            }
            
            vc = SurveySecondViewController()
            
            
        } else {
            vc = LoginViewController()
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func clickYesButton() {
        handleSurveyAction(action: true)
    }
    
    @objc func clickNoButton() {
        handleSurveyAction(action: false)
    }
    
}
