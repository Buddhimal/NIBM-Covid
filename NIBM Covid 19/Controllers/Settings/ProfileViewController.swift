//
//  ProfileViewController.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 9/6/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycale
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Avenir" , size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempratureTextview: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string:  "0.0", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)])
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.backgroundColor = .backgroundColor
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let indexNoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Index Number"
        textField.backgroundColor = .backgroundColor
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let countryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Country"
        textField.backgroundColor = .backgroundColor
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "user")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    private let updateButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("UPDATE", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Profile"
        configureUI()
        getUserData()
    }
    
    @objc func handleLoginRegister() {
        handleRegister()
    }

    
    //MARK: Methods
    
    func configureUI(){
        
        let imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let inputView = UIView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        imageView.addSubview(nameLabel)
        imageView.addSubview(profileImageView)
        imageView.addSubview(tempratureTextview)
        profileImageView.layer.cornerRadius = 50


        view.addSubview(inputView)
        inputView.addSubview(nameTextField)
        inputView.addSubview(indexNoTextField)
        inputView.addSubview(countryTextField)
        
        
        let bottomControlStackView = UIStackView(arrangedSubviews: [updateButton])
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlStackView)
        
        NSLayoutConstraint.activate([
            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 50)
            
        ])

        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor,constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 10),
            profileImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            profileImageView.heightAnchor.constraint(equalToConstant: 150),
            
            tempratureTextview.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant: 10),
            tempratureTextview.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            
            inputView.bottomAnchor.constraint(equalTo: bottomControlStackView.topAnchor),
            inputView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            inputView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            inputView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
//            nameTextField
            nameTextField.topAnchor.constraint(equalTo: inputView.topAnchor,constant: 30),
            nameTextField.leadingAnchor.constraint(equalTo: inputView.leadingAnchor,constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: inputView.trailingAnchor,constant: -10),
            nameTextField.heightAnchor.constraint(equalTo: inputView.heightAnchor,multiplier: 0.1),
            nameTextField.centerXAnchor.constraint(equalTo: inputView.centerXAnchor),
            
            indexNoTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,constant: 30),
            indexNoTextField.leadingAnchor.constraint(equalTo: inputView.leadingAnchor,constant: 10),
            indexNoTextField.trailingAnchor.constraint(equalTo: inputView.trailingAnchor,constant: -10),
            indexNoTextField.heightAnchor.constraint(equalTo: inputView.heightAnchor,multiplier: 0.1),
            indexNoTextField.centerXAnchor.constraint(equalTo: inputView.centerXAnchor),
            
            countryTextField.topAnchor.constraint(equalTo: indexNoTextField.bottomAnchor,constant: 30),
            countryTextField.leadingAnchor.constraint(equalTo: inputView.leadingAnchor,constant: 10),
            countryTextField.trailingAnchor.constraint(equalTo: inputView.trailingAnchor,constant: -10),
            countryTextField.heightAnchor.constraint(equalTo: inputView.heightAnchor,multiplier: 0.1),
            countryTextField.centerXAnchor.constraint(equalTo: inputView.centerXAnchor),
            
        ])
    }
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func getUserData(){
        showUniversalLoadingView(true, loadingText: "Fetching Data..")
        Service.shared.fetchUserData(uid: Service.shared.loginUserId!) { (User) in
            print("Logged User Id .........")
            print(User.profileImageUrl)
            
            if(User.profileImageUrl != ""){
                let url = URL(string: User.profileImageUrl)!
                self.downloadImage(from: url)
            }
            
            self.nameLabel.text = User.firstName + " " + User.lastName
            self.nameTextField.text = User.firstName
            self.indexNoTextField.text = User.indexNo
            self.countryTextField.text = User.country
            self.tempratureTextview.text = User.temprature + " ℃"
            
            showUniversalLoadingView(false, loadingText: "Fetching Data..")
            
        }
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.profileImageView.image = UIImage(data: data)
                self?.profileImageView.layer.cornerRadius = 50
                self?.profileImageView.clipsToBounds = true
            }
        }
    }
    
    
    func handleRegister() {
        
        guard  let indexNo = indexNoTextField.text else { return }
        guard let country = countryTextField.text else { return }
        guard let name = nameTextField.text else { return }
        
        if(indexNo == "" || country == "" || name == ""){
            self.present(showMainAlert(title: "Error", text: "Please fill All fields"), animated: true, completion: nil)

            return
        }
        showUniversalLoadingView(true, loadingText: "Uploading image..")

        //successfully authenticated user
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
        
        if let uploadData = self.profileImageView.image!.pngData() {
            
            storageRef.putData(uploadData, metadata: nil, completion: { (_, err) in
                
                if let error = err {
                    self.present(showMainAlert(title: "Error", text: error.localizedDescription), animated: true, completion: nil)
                    return
                }
                
                storageRef.downloadURL(completion: { (url, err) in
                    if let err = err {
                        print(err)
                        self.present(showMainAlert(title: "Error", text: err.localizedDescription), animated: true, completion: nil)
                        return
                    }
                    
                    guard let url = url else { return }
                    let values = ["name": name, "indexNo": indexNo, "profileImageUrl": url.absoluteString, "country":country]
                    
                    self.updateUserWithImage(Service.shared.loginUserId!, values: values as [String : AnyObject])
                    
                })
                showUniversalLoadingView(false, loadingText: "Saving Data..")
                self.present(showMainAlert(title: "Success", text: "Profile Updated Successfully"), animated: true, completion: nil)

//                self.getUserData()
            })
        }
        
    }
    
    fileprivate func updateUserWithImage(_ uid: String, values: [String: AnyObject]) {
        
        Service.shared.updateUserWithImage(imageUrl:values["profileImageUrl"] as! String, username: values["name"] as! String, indexNo: values["indexNo"] as! String, country: values["country"] as! String)
    }
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
