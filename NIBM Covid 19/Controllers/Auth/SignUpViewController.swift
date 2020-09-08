//
//  SignUpViewController.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 8/29/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create An Account"
        label.font = UIFont(name: "Avenir-Light", size: 20)
        
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var firstNameContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: firstNameTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    
    private lazy var lastNameContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: lastNameTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let accountTypeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Student", "Staff"])
        sc.backgroundColor = UIColor.rgb(red: 156, green: 68, blue: 109)
        sc.tintColor = UIColor(white: 1, alpha: 0.87)
        sc.selectedSegmentIndex = 0
        
        return sc
    }()

    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let emailTextFiled: UITextField = {
        return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
    }()
    
    private let firstNameTextFiled: UITextField = {
        return UITextField().textField(withPlaceholder: "First Name", isSecureTextEntry: false)
    }()
    
    private let lastNameTextFiled: UITextField = {
        return UITextField().textField(withPlaceholder: "Last Name", isSecureTextEntry: false)
    }()
    
    private let passwordTextFiled: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private let signUpButton: AuthButtonUIButton = {
        let button = AuthButtonUIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        return button
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
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor(white: 1, alpha: 1), for: .normal)
        button.backgroundColor = UIColor.rgb(red: 161, green: 111, blue: 134)
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    
    // MARK: - Functions
    
    @objc func handleShowLogIn() {
        print("Debug: call Log In")
        
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
//        navigationController?.navigationBar.barStyle = .black
    }
    
    
    
    // MARK: - Selectors
    
    @objc func handleSignUp() {
        guard let email = emailTextFiled.text else { return }
        guard let password = passwordTextFiled.text else { return }
        guard let firstName = firstNameTextFiled.text else { return }
        guard let lastName = lastNameTextFiled.text else { return }
        let role = accountTypeSegmentedControl.selectedSegmentIndex

        
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Faild to register user with error \(error)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let values = [
                "email": email,
                "firstName": firstName,
                "lastName": lastName,
                "role": role
                ] as [String : Any]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
                print("Successfuly Registerd and save data..")
            }
        }
                
    }
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            configureUI()
        }
        
        func configureUI(){
            
            configureNavigationBar();
            
            view.backgroundColor = UIColor.backgroundColor
            
            view.addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            
            let stack = UIStackView(arrangedSubviews: [ firstNameContainerView,lastNameContainerView,emailContainerView, passwordContainerView,accountTypeSegmentedControl,signUpButton,termsAndConditionsButton,alreadyHaveAccountButton
                
            ])
            stack.axis = .vertical
            stack.distribution = .fillProportionally
            stack.spacing = 24
            
            view.addSubview(stack)
            stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
            
        }
        
}

