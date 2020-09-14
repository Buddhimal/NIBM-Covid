//
//  SettingsViewController.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 9/5/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    let button = UIButton()
    
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Profile", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0);
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(clickProfileButton), for: .touchUpInside)
        
        return button
    }()
    
    private let contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Contact Us / About Us", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 0);
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(clickContactButton), for: .touchUpInside)
        
        return button
    }()
    
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share With Friends", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0);
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(clickShareButton), for: .touchUpInside)
        
        return button
    }()
    
    
    
    private let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOGOUT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(clickLogOutButton), for: .touchUpInside)
        
        return button
    }()
    
    
    
    //    MARK: Controls
    
    private func setButtonControl(){
        
        let topControlStackView = UIStackView(arrangedSubviews: [profileButton,contactButton,shareButton])
        topControlStackView.translatesAutoresizingMaskIntoConstraints = false
        topControlStackView.axis = .vertical
        
        
        view.addSubview(topControlStackView)
        
        NSLayoutConstraint.activate([
            topControlStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            //            topControlStackView.heightAnchor.constraint(equalToConstant: 100)
            
            
        ])
        
        
        let bottomControlStackView = UIStackView(arrangedSubviews: [logOutButton])
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Settings"
        
        checkUserLoggedIn()
        //
        //        view.addSubview(button)
        //        button.setTitle("Click me", for: .normal)
        //        button.backgroundColor = .white
        //        button.setTitleColor(.black, for: .normal)
        //        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        //        button.addTarget(self, action: #selector(didtapButton), for: .touchUpInside)
    }
    
    
    @objc private func clickContactButton() {
        let rootVC = AboutUsViewController()
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc private func clickShareButton() {
        let rootVC = ShareViewController()
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc private func clickProfileButton() {
        let rootVC = ProfileViewController()
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc private func clickLogOutButton() {
        
        do{
            try
                Auth.auth().signOut()
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
                
            
        } catch{
            print("Sign out Error")
        }
        
    }
    
    func checkUserLoggedIn(){
        if(Auth.auth().currentUser?.uid == nil){
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else{
            setButtonControl()
        }
    }
    
}

