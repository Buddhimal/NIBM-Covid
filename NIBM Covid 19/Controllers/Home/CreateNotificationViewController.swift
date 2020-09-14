//
//  CreateNotificationViewController.swift
//  NIBM Covid 19
//
//  Created by TM on 9/15/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateNotificationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "New Notification"
        configureUI();
        // Do any additional setup after loading the view.
    }
    
    private let createTextView: UILabel = {
        
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 3
        let attributedText = NSMutableAttributedString(string:  "Create New Notification", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        text.attributedText = attributedText
        return text
    }()
    
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Title"
        //        textField.textAlignment = .center
        textField.backgroundColor = .backgroundColor
        //        textField.frame = CGRect(x: 10, y: 10, width: 120, height: 50)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        
        return textField
    }()
    
    
    private let textTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Message"
        //        textField.textAlignment = .center
        textField.backgroundColor = .backgroundColor
        //        textField.frame = CGRect(x: 10, y: 10, width: 120, height: 80)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("S A V E", for: .normal)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(addNotification), for: .touchUpInside)
        
        
        return button
    }()
    
    
    private func configureUI(){
        
        let createView = UIView()
        createView.translatesAutoresizingMaskIntoConstraints = false
        createView.backgroundColor = .white
        view.addSubview(createView)
        
        createView.addSubview(createTextView)
        
        
        let inputView = UIView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.backgroundColor = .white
        view.addSubview(inputView)
        
        inputView.addSubview(titleTextField)
        inputView.addSubview(textTextField)
        inputView.addSubview(saveButton)
        
        
        NSLayoutConstraint.activate([
            
            createView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            createView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            createView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            createView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.1),
            
            //        createTextView.leadingAnchor.constraint(equalTo: createView.leadingAnchor, constant: 15 ),
            createTextView.centerYAnchor.constraint(equalTo: createView.centerYAnchor),
            createTextView.centerXAnchor.constraint(equalTo: createView.centerXAnchor),
            
            
            inputView.topAnchor.constraint(equalTo: createView.bottomAnchor, constant: 20),
            inputView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            inputView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            inputView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.6),
            
            
            titleTextField.topAnchor.constraint(equalTo: inputView.topAnchor,constant: 30),
            titleTextField.leadingAnchor.constraint(equalTo: inputView.leadingAnchor,constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: inputView.trailingAnchor,constant: -10),
            titleTextField.heightAnchor.constraint(equalTo: inputView.heightAnchor,multiplier: 0.1),
            titleTextField.centerXAnchor.constraint(equalTo: inputView.centerXAnchor),
            textTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 40),
            textTextField.centerXAnchor.constraint(equalTo: inputView.centerXAnchor),
            textTextField.leadingAnchor.constraint(equalTo: inputView.leadingAnchor,constant: 10),
            textTextField.trailingAnchor.constraint(equalTo: inputView.trailingAnchor,constant: -10),
            textTextField.heightAnchor.constraint(equalTo: inputView.heightAnchor,multiplier: 0.4),
            
            
            saveButton.topAnchor.constraint(equalTo: textTextField.bottomAnchor,constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: inputView.centerXAnchor),
            
        ])
        
    }
    
    @objc private func addNotification() {
        
        guard let title = titleTextField.text else { return }
        guard let text = textTextField.text else { return }
        
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        
        if(title == nil || text == "" ){
            
            self.showAlert(title: "Error", text: "Please enter Title message")
            
        } else{
            showUniversalLoadingView(true, loadingText: "Saving Data..")
            let values = [
                "title": title,
                "text": text,
                "created": formatter.string(from: date),
                ] as [String : Any]
            
            
            Database.database().reference().child("notifications").child(title).updateChildValues(values) { (error, ref) in
                if let error = error {
                    self.showAlert(title: "Error", text: error.localizedDescription)
                    return
                }
                
            showUniversalLoadingView(false, loadingText: "Fetching Data..")
            self.showAlert(title: "Success", text: "Message saved successfully")
                self.titleTextField.text = nil
                self.textTextField.text = nil
            }
        }
        
    }
    
    func showAlert(title: String, text: String){
        let uialert = UIAlertController(title: title, message: text , preferredStyle: UIAlertController.Style.alert)
        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(uialert, animated: true, completion: nil)
        
    }
    
    
}
