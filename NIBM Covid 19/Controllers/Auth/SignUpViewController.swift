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
import GeoFire
import KeychainSwift

class SignUpViewController: UIViewController {
    
    private var location = LocationHandler.shared.locationManager.location
    
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create An Account"
        label.font = UIFont(name: "Avenir-Light", size: 20)
        
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        let attributedTitle = NSMutableAttributedString(string: "Close", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "email"), textField: emailTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var firstNameContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "name"), textField: firstNameTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    
    private lazy var lastNameContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "name"), textField: lastNameTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let accountTypeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Student", "Staff","Non – Academic"])
        sc.backgroundColor = UIColor.rgb(red: 156, green: 68, blue: 109)
        sc.tintColor = UIColor(white: 1, alpha: 0.87)
        sc.selectedSegmentIndex = 0
        
        return sc
    }()
    
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "password"), textField: passwordTextFiled)
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
    
    
    @objc func handleClose(){
        let nav = UINavigationController(rootViewController: HomeViewController())
        
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)

    }

    
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
        button.backgroundColor = UIColor.white
//        button.backgroundColor = UIColor.rgb(red: 161, green: 111, blue: 134)
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
        
                

        if(validateSignUp()){
            showUniversalLoadingView(true, loadingText: "Sign In..")
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    let uialert = UIAlertController(title: "Error", message: error.localizedDescription , preferredStyle: UIAlertController.Style.alert)
                    uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                    self.present(uialert, animated: true, completion: nil)
                    return
                }
                
                let keychain = KeychainSwift()
                
                keychain.set(email, forKey: "userName")
                keychain.set(password, forKey: "password")

                
                guard let uid = result?.user.uid else { return }
                Service.shared.loginUserId = Auth.auth().currentUser?.uid
                
                let values = [
                    "email": email,
                    "firstName": firstName,
                    "lastName": lastName,
                    "role": role
                    ] as [String : Any]
                
                //            if accountType == 1 {
                let geoFire = GeoFire(firebaseRef: REF_USER_LOCATIONS)
                
                guard let location = self.location else { return }
                
                geoFire.setLocation(location, forKey: uid, withCompletionBlock: { (error) in
                    self.uploadUserDataAndShowHomeController(uid: uid, values: values)
                })
                //            }
                
                self.uploadUserDataAndShowHomeController(uid: uid, values: values)
                
                //            Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
                //                print("Successfuly Registerd and save data..")
                //            }
            }
            showUniversalLoadingView(false, loadingText: "Login In..")
        }

        
    }
    
    func validateSignUp() -> Bool {
        
        let email = emailTextFiled.text
        let password = passwordTextFiled.text
        let firstName = firstNameTextFiled.text
        let lastName = lastNameTextFiled.text
        var isValid = true
        
        if(email == nil || email == "" ){
            
            isValid = false;
            
            let uialert = UIAlertController(title: "Error", message: "Please Enter Email Address" , preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
            
        }
        
        if(password == nil || password == "" ){
            
            isValid = false;
            
            let uialert = UIAlertController(title: "Error", message: "Please Enter Password" , preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
        }
        
        if(firstName == nil || firstName == "" ){
            
            isValid = false;
            
            let uialert = UIAlertController(title: "Error", message: "Please Enter First Name" , preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
        }
        if(lastName == nil || lastName == "" ){
            
            isValid = false;
            
            let uialert = UIAlertController(title: "Error", message: "Please Enter Last Name" , preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
        }
        return (isValid)

        

    }
    
    func uploadUserDataAndShowHomeController(uid: String, values: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
            if let error = error {
                let uialert = UIAlertController(title: "Error", message: error.localizedDescription , preferredStyle: UIAlertController.Style.alert)
                uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                self.present(uialert, animated: true, completion: nil)
                return
            }
            
            
            
            let nav = UINavigationController(rootViewController: HomeViewController())

            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            
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
        view.addSubview(closeButton)
        
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 0).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [ firstNameContainerView,lastNameContainerView,emailContainerView, passwordContainerView,accountTypeSegmentedControl,signUpButton,termsAndConditionsButton,alreadyHaveAccountButton
            
        ])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
    }
    
}

