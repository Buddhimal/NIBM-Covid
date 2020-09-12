//
//  HomeViewController.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 8/30/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
        
        
//        configureNavigationBar()
        setStayHomeControl()
        setBottomButtonControl()
        
//        signout()
//        checkUserLoggedIn()
        
    }
    
    //   MARK: UI Components
    
    private let homeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Home", for: .normal)
        button.setImage(UIImage(systemName: "house.fill"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alignImageAndTitleVertically()
        return button
    }()
    
    
    private let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Profile", for: .normal)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alignImageAndTitleVertically()
        return button
    }()
    
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Settings", for: .normal)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alignImageAndTitleVertically()
        
        button.addTarget(self, action: #selector(clickSettingsButton), for: .touchUpInside)
        
        return button
    }()
    
    
    let symptomsImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "stay_home") )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let stayHomeTextView: UILabel = {
        
        let ImageText = UILabel()
        ImageText.translatesAutoresizingMaskIntoConstraints = false
        ImageText.numberOfLines = 3
        let attributedText = NSMutableAttributedString(string:  "All you need is", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        attributedText.append(NSMutableAttributedString(string: "\nstay at home", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.black ]))
        
        ImageText.attributedText = attributedText
        return ImageText
    }()
    
    
    let stayhomeImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "stay_home") )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let btnSafeAction: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Safe actions  ", for: .normal)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.semanticContentAttribute = .forceRightToLeft
        
        return button
    }()
    
    
    let notificationImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bell") )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let bellIconTextView: UILabel = {
        
        let ImageText = UILabel()
        ImageText.translatesAutoresizingMaskIntoConstraints = false
        ImageText.numberOfLines = 3
        let attributedText = NSMutableAttributedString(string:  "NIBM is closed until further notice", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        attributedText.append(NSMutableAttributedString(string: "\nstay at home", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black ]))
        
        ImageText.attributedText = attributedText
        return ImageText
    }()
    
    let caseUpdateTextView: UILabel = {
        
        let ImageText = UILabel()
        ImageText.translatesAutoresizingMaskIntoConstraints = false
        ImageText.numberOfLines = 3
//        ImageText.backgroundColor = .gray
        let attributedText = NSMutableAttributedString(string:  "Univercity Case Updates", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        ImageText.attributedText = attributedText
        return ImageText
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let seeMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See more", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let infectedImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "infected") )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let deathsImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "deaths") )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let recoveredImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "success-icon") )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let infectedTextview: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string:  "3", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()
    
    let deathsTextview: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string:  "0", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()
    
    let recoveredTextview: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string:  "10", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()
    
    let infectedLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string:  "Infected", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        uiLabel.attributedText = attributedText
        return uiLabel
    }()
    
    let deathsLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string:  "Deaths", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        uiLabel.attributedText = attributedText
        return uiLabel
    }()
    
    let recoveredLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string:  "Recovered", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        uiLabel.attributedText = attributedText
        return uiLabel
    }()
    
    
    
    
    
    //    MARK: Contfigurations
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    //    MARK: Controls
    
    private func setStayHomeControl(){
        let stayHomeImageContainerView = UIView()
        stayHomeImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stayHomeImageContainerView)
        
        stayHomeImageContainerView.addSubview(stayhomeImageView)
        
        let stayHomeTextContainerView = UIView()
        stayHomeTextContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stayHomeTextContainerView)
        
        stayHomeTextContainerView.addSubview(stayHomeTextView)
        stayHomeTextContainerView.addSubview(btnSafeAction)
                
        
        let bellIconStackView = UIView()
        bellIconStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bellIconStackView)

        bellIconStackView.addSubview(notificationImageView)
        bellIconStackView.addSubview(bellIconTextView)
        bellIconStackView.addSubview(nextButton)
        
        let caseUpdateStackView = UIView()
        caseUpdateStackView.translatesAutoresizingMaskIntoConstraints = false
//        caseUpdateStackView.backgroundColor = .gray
        view.addSubview(caseUpdateStackView)
        
        caseUpdateStackView.addSubview(caseUpdateTextView)
        caseUpdateStackView.addSubview(seeMoreButton)
        
        
        //corona case count down
        let infectedStackView = UIView()
        infectedStackView.translatesAutoresizingMaskIntoConstraints = false
//        infectedStackView.backgroundColor = .gray
        view.addSubview(infectedStackView)
        infectedStackView.addSubview(infectedImageView)
        infectedStackView.addSubview(infectedTextview)
        infectedStackView.addSubview(infectedLabel)
        
        
        let deathsStackView = UIView()
        deathsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deathsStackView)
        deathsStackView.addSubview(deathsImageView)
        deathsStackView.addSubview(deathsTextview)
        deathsStackView.addSubview(deathsLabel)
        

        let recoveredStackView = UIView()
        recoveredStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recoveredStackView)
        recoveredStackView.addSubview(recoveredImageView)
        recoveredStackView.addSubview(recoveredTextview)
        recoveredStackView.addSubview(recoveredLabel)

        

        
        
        NSLayoutConstraint.activate([
            stayHomeImageContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stayHomeImageContainerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 5),
            stayHomeImageContainerView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            stayHomeImageContainerView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.2),
            
            stayhomeImageView.centerYAnchor.constraint(equalTo: stayHomeImageContainerView.centerYAnchor),
//            stayhomeImageView.centerXAnchor.constraint(equalTo: stayHomeImageContainerView.centerXAnchor),
            stayhomeImageView.heightAnchor.constraint(equalTo: stayHomeImageContainerView.heightAnchor, multiplier: 0.8),
            stayhomeImageView.widthAnchor.constraint(equalTo: stayHomeImageContainerView.widthAnchor, multiplier: 0.8, constant: -10),

            stayHomeTextContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stayHomeTextContainerView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -5),
            stayHomeTextContainerView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            stayHomeTextContainerView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.2),

            btnSafeAction.topAnchor.constraint(equalTo: stayHomeTextView.bottomAnchor, constant: 5),
            stayHomeTextView.centerYAnchor.constraint(equalTo: stayhomeImageView.centerYAnchor),
            
            
            bellIconStackView.topAnchor.constraint(equalTo: stayHomeImageContainerView.bottomAnchor),
            bellIconStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bellIconStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bellIconStackView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.1),
            bellIconStackView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.2),

            
            notificationImageView.centerYAnchor.constraint(equalTo: bellIconStackView.centerYAnchor),
            notificationImageView.centerXAnchor.constraint(equalTo: bellIconStackView.centerXAnchor),
            notificationImageView.heightAnchor.constraint(equalTo: bellIconStackView.heightAnchor, multiplier: 0.6),
            notificationImageView.widthAnchor.constraint(equalTo: bellIconStackView.widthAnchor, multiplier: 0.6),
            
            bellIconTextView.leadingAnchor.constraint(equalTo: notificationImageView.trailingAnchor, constant: 15 ),
            bellIconTextView.centerYAnchor.constraint(equalTo: notificationImageView.centerYAnchor),

            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35 ),
            nextButton.centerYAnchor.constraint(equalTo: notificationImageView.centerYAnchor),
            
            
            caseUpdateStackView.topAnchor.constraint(equalTo: bellIconStackView.bottomAnchor, constant: 10),
            caseUpdateStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            caseUpdateStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            caseUpdateStackView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.05),
//            caseUpdateStackView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, constant: 20),
            
            seeMoreButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25 ),
            seeMoreButton.centerYAnchor.constraint(equalTo: caseUpdateStackView.centerYAnchor),
            caseUpdateTextView.centerYAnchor.constraint(equalTo: caseUpdateStackView.centerYAnchor),


        ])
        
        
        
        // create corona count view
        
        let coundDownControlStackView = UIStackView(arrangedSubviews: [infectedStackView,deathsStackView,recoveredStackView])
        coundDownControlStackView.translatesAutoresizingMaskIntoConstraints = false
        coundDownControlStackView.distribution = .fillEqually
        
        
        view.addSubview(coundDownControlStackView)
        
        
        NSLayoutConstraint.activate([
            coundDownControlStackView.topAnchor.constraint(equalTo: caseUpdateStackView.bottomAnchor),
            coundDownControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            coundDownControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            coundDownControlStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),

            //infected
            infectedImageView.topAnchor.constraint(equalTo: caseUpdateStackView.topAnchor, constant: 40),
            infectedImageView.leadingAnchor.constraint(equalTo: caseUpdateStackView.leadingAnchor),
            infectedImageView.centerXAnchor.constraint(equalTo: infectedStackView.centerXAnchor),
            infectedImageView.heightAnchor.constraint(equalTo: infectedStackView.heightAnchor, multiplier: 0.1),
            
            infectedTextview.topAnchor.constraint(equalTo: infectedImageView.bottomAnchor, constant: 0),
            infectedTextview.centerXAnchor.constraint(equalTo: infectedStackView.centerXAnchor),
            
            infectedLabel.topAnchor.constraint(equalTo: infectedTextview.bottomAnchor, constant: 0),
            infectedLabel.centerXAnchor.constraint(equalTo: infectedStackView.centerXAnchor),
            
            //deaths
            deathsImageView.topAnchor.constraint(equalTo: caseUpdateStackView.topAnchor, constant: 40),
            deathsImageView.leadingAnchor.constraint(equalTo: caseUpdateStackView.leadingAnchor),
            deathsImageView.centerXAnchor.constraint(equalTo: deathsStackView.centerXAnchor),
            deathsImageView.heightAnchor.constraint(equalTo: deathsStackView.heightAnchor, multiplier: 0.1),
            
            deathsTextview.topAnchor.constraint(equalTo: deathsImageView.bottomAnchor, constant: 0),
            deathsTextview.centerXAnchor.constraint(equalTo: deathsStackView.centerXAnchor),

            deathsLabel.topAnchor.constraint(equalTo: deathsTextview.bottomAnchor, constant: 0),
            deathsLabel.centerXAnchor.constraint(equalTo: deathsStackView.centerXAnchor),

            
            //recovered
            recoveredImageView.topAnchor.constraint(equalTo: caseUpdateStackView.topAnchor, constant: 40),
            recoveredImageView.leadingAnchor.constraint(equalTo: caseUpdateStackView.leadingAnchor),
            recoveredImageView.centerXAnchor.constraint(equalTo: recoveredStackView.centerXAnchor),
            recoveredImageView.heightAnchor.constraint(equalTo: recoveredStackView.heightAnchor, multiplier: 0.11),
            
            recoveredTextview.topAnchor.constraint(equalTo: recoveredImageView.bottomAnchor, constant: 0),
            recoveredTextview.centerXAnchor.constraint(equalTo: recoveredStackView.centerXAnchor),

            recoveredLabel.topAnchor.constraint(equalTo: recoveredTextview.bottomAnchor, constant: 0),
            recoveredLabel.centerXAnchor.constraint(equalTo: recoveredStackView.centerXAnchor),
        ])


    }
        
    
    private func setBottomButtonControl(){
        
        let bottomControlStackView = UIStackView(arrangedSubviews: [homeButton,updateButton,settingsButton])
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
    
    
    //MARK: Functions
    
    @objc private func clickSettingsButton() {
        let rootVC = SettingsViewController()
        navigationController?.pushViewController(rootVC, animated: true)
    }

    
    
    // MARK: API
    
    func checkUserLoggedIn(){
        if(Auth.auth().currentUser?.uid == nil){
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else{
            print ("logged in")
        }
    }
    
    func signout(){
        do{
            try Auth.auth().signOut()
        } catch{
            print("Sign out Error")
        }
    }
    
}
