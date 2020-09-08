//
//  MainViewController.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 8/29/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NIBM COVID-19"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        
        return label
    }()
    
    let termsAndConditionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        button.titleLabel?.textAlignment = NSTextAlignment.center
        
        let attributedTitle = NSMutableAttributedString(string: "By signing up, you agree with the ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black])
        
        attributedTitle.append(NSAttributedString(string: "Terms of Services", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        attributedTitle.append(NSAttributedString(string: " & ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]))
        
        attributedTitle.append(NSAttributedString(string: "Privacy Policy", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    let covidImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = UIImage(named:"CovidIcon")!
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        return myImageView
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureNavigationBar()
        
        view.backgroundColor = UIColor.init(red: 196/255, green: 195/255, blue: 192/255, alpha: 1)
        
        configureUI()
        
        // Do any additional setup after loading the view.
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    func configureUI() {
        
        self.view.addSubview(covidImageView)
        view.removeConstraints(view.constraints)
        view.addConstraint(NSLayoutConstraint(
            item: covidImageView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant:100)
        )
        view.addConstraint(NSLayoutConstraint(
            item: covidImageView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1,
            constant:0)
        )
        
        view.addConstraint(NSLayoutConstraint(
            item: covidImageView,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.5,
            constant:40))
        
        view.addConstraint(NSLayoutConstraint(
            item: covidImageView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.5,
            constant:40))
        
        
        view.addSubview(termsAndConditionsButton)
        termsAndConditionsButton.centerX(inView: view)
        termsAndConditionsButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 50)
        
        
        
    }
    
    
}
