//
//  UpdateViewController.swift
//  NIBM Covid 19
//
//  Created by TM on 9/12/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseDatabase


class UpdateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Update"
        view.backgroundColor = UIColor.backgroundColor
        configureUI()
        setTempreture()
    }
    
    private let createTextView: UILabel = {
        
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 3
        let attributedText = NSMutableAttributedString(string:  "C R E A T E +", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        text.attributedText = attributedText
        return text
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        //        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    private let notificationTextView: UILabel = {
        
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 3
        let attributedText = NSMutableAttributedString(string:  "Create Notification", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        
        text.attributedText = attributedText
        return text
    }()
    
    private let notificationNextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let newSurveyTextView: UILabel = {
        
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 3
        let attributedText = NSMutableAttributedString(string:  "New Survey \n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        
        attributedText.append(NSMutableAttributedString(string:  "Last Update: 2020-02-01", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
        
        
        text.attributedText = attributedText
        return text
    }()
    
    private let newSurveyNextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    private let degreeLabel: UILabel = {
        let textLabel = UILabel()
        let attributedText = NSMutableAttributedString(string:  "℃", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        
        
        textLabel.attributedText = attributedText
        textLabel.textAlignment = .center
        //        textView.isEditable = false
        //        textView.isScrollEnabled = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return textLabel
    }()
    
    private let lastUpdateLabel: UILabel = {
        let textLabel = UILabel()
        let attributedText = NSMutableAttributedString(string:  "Last Updated: 1 Day ago", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        
        
        textLabel.attributedText = attributedText
        textLabel.textAlignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return textLabel
    }()
    
    
    private let tempratureTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Enter Your Temprature", isSecureTextEntry: false)
    }()
    
    private let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("U P D A T E", for: .normal)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(updateTemp), for: .touchUpInside)
        
        
        return button
    }()
    
    @objc private func updateTemp(){
        
        showUniversalLoadingView(true, loadingText: "Saving Data..")
        guard let temp = tempratureTextField.text else { return }
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        if (Double(temp) == nil){
            let uialert = UIAlertController(title: "Error", message: "Please enter a valied temprature" , preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
        } else {
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy HH:mm"

            
            let values = [
                "bodyTemperature": temp,
                "bodyTemperatureUpdated": formatter.string(from: date),
                ] as [String : Any]

            
            Database.database().reference().child("users").child(userID).updateChildValues(values) { (error, ref) in
                if let error = error {
                    let uialert = UIAlertController(title: "Error", message: error.localizedDescription , preferredStyle: UIAlertController.Style.alert)
                    uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                    self.present(uialert, animated: true, completion: nil)
                    return
                } else{
                    self.setTempreture()
                    self.tempratureTextField.text = nil
                    showUniversalLoadingView(false, loadingText: "")
                }
            }
        }
    }
    
    private func setTempreture(){
        showUniversalLoadingView(true, loadingText: "Fetching Data..")
        let userID = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user body temparature value
            let value = snapshot.value as? NSDictionary
            let temparature = value?["bodyTemperature"] as? String ?? ""
            let temparatureUpdated = value?["bodyTemperatureUpdated"] as? String ?? ""
            self.tempratureTextview.text = temparature
            showUniversalLoadingView(false, loadingText: "")
            
            let date = Date()
            let formatter = DateFormatter()
            let calendar = Calendar.current
            // specify the format,
            formatter.dateFormat = "dd-MM-yyyy HH:mm"
            
            let updatedAt = formatter.date(from: temparatureUpdated)
            let today = formatter.date(from: formatter.string(from: date))
            
            let diff = calendar.dateComponents([.minute,.hour,.day], from: updatedAt!, to: today!)
            
            var msg = "Last Updated: 0 Day ago"
            
            if(diff.day! > 0){
                msg = "Last Update: " + "\(diff.day!)" + " Day ago"
            } else if(diff.hour! > 0){
                msg = "Last Update: " + "\(diff.hour!)" + " Hour ago"
            } else{
                msg = "Last Update: " + "\(diff.minute!)" + " Minutes ago"
            }
            
            self.lastUpdateLabel.text =  msg
            

        }) { (error) in
            showUniversalLoadingView(false, loadingText: "")
            let uialert = UIAlertController(title: "Error", message: error.localizedDescription , preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
            return
        }
    }
    
    private func configureUI(){
        
        let createView = UIView()
        createView.translatesAutoresizingMaskIntoConstraints = false
        createView.backgroundColor = .white
        view.addSubview(createView)
        
        createView.addSubview(createTextView)
        createView.addSubview(closeButton)
        
        
        
        let createNotificationView = UIView()
        createNotificationView.translatesAutoresizingMaskIntoConstraints = false
        createNotificationView.backgroundColor = .white
        //        createNotificationView.isHidden = true
        view.addSubview(createNotificationView)
        createNotificationView.addSubview(notificationTextView)
        createNotificationView.addSubview(notificationNextButton)
        
        let newSurveyView = UIView()
        newSurveyView.translatesAutoresizingMaskIntoConstraints = false
        newSurveyView.backgroundColor = .white
        view.addSubview(newSurveyView)
        
        newSurveyView.addSubview(newSurveyTextView)
        newSurveyView.addSubview(newSurveyNextButton)
        
        
        let updateView = UIView()
        updateView.translatesAutoresizingMaskIntoConstraints = false
        updateView.backgroundColor = .white
        view.addSubview(updateView)
        
        updateView.addSubview(tempratureTextview)
        updateView.addSubview(degreeLabel)
        updateView.addSubview(lastUpdateLabel)
        updateView.addSubview(tempratureTextField)
        tempratureTextField.translatesAutoresizingMaskIntoConstraints = false
        updateView.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            createView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            createView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            createView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            createView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.06),
            
            //            closeButton.topAnchor.constraint(equalTo: createView.topAnchor, constant: 10),
            createTextView.leadingAnchor.constraint(equalTo: createView.leadingAnchor, constant: 15 ),
            createTextView.centerYAnchor.constraint(equalTo: createView.centerYAnchor),
            
            
            closeButton.trailingAnchor.constraint(equalTo: createView.trailingAnchor, constant: -15 ),
            closeButton.centerYAnchor.constraint(equalTo: createView.centerYAnchor),
            
            
            createNotificationView.topAnchor.constraint(equalTo:createView.bottomAnchor, constant: 10),
            createNotificationView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            createNotificationView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            createNotificationView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.1),
            
            notificationTextView.leadingAnchor.constraint(equalTo: createNotificationView.leadingAnchor, constant: 15 ),
            notificationTextView.centerYAnchor.constraint(equalTo: createNotificationView.centerYAnchor),
            
            notificationNextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35 ),
            notificationNextButton.centerYAnchor.constraint(equalTo: createNotificationView.centerYAnchor),
            
            
            newSurveyView.topAnchor.constraint(equalTo:createNotificationView.bottomAnchor, constant: 10),
            newSurveyView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            newSurveyView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            newSurveyView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.1),
            
            newSurveyTextView.leadingAnchor.constraint(equalTo: newSurveyView.leadingAnchor, constant: 15 ),
            newSurveyTextView.centerYAnchor.constraint(equalTo: newSurveyView.centerYAnchor),
            
            newSurveyNextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35 ),
            newSurveyNextButton.centerYAnchor.constraint(equalTo: newSurveyView.centerYAnchor),
            
            updateView.topAnchor.constraint(equalTo:newSurveyView.bottomAnchor, constant: 30),
            updateView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            updateView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            updateView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.5),
            
            tempratureTextview.centerXAnchor.constraint(equalTo: updateView.centerXAnchor),
            degreeLabel.topAnchor.constraint(equalTo: tempratureTextview.topAnchor, constant: 10),
            degreeLabel.leadingAnchor.constraint(equalTo: tempratureTextview.trailingAnchor, constant: 5),
            
            lastUpdateLabel.topAnchor.constraint(equalTo: tempratureTextview.bottomAnchor),
            lastUpdateLabel.centerXAnchor.constraint(equalTo: updateView.centerXAnchor),
            
            tempratureTextField.topAnchor.constraint(equalTo: lastUpdateLabel.bottomAnchor, constant: 60),
            tempratureTextField.centerXAnchor.constraint(equalTo: updateView.centerXAnchor),
            
            updateButton.topAnchor.constraint(equalTo: tempratureTextField.bottomAnchor, constant: 50),
            updateButton.centerXAnchor.constraint(equalTo: updateView.centerXAnchor),
            
        ])
        
    }
    
}
