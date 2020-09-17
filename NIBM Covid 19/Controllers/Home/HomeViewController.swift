//
//  DashboardViewController.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 8/30/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit

private let reuseIdentifier = "LocationCell"
private let annotationIdentifier = "DriverAnnotation"

class HomeViewController: UIViewController {
    
    private let locationManager = LocationHandler.shared.locationManager
    private let mapView = MKMapView()
    private var route: MKRoute?
    var userNotificationArray = [String]()
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.showToast(message: "Your Toast Message", font: .systemFont(ofSize: 12.0))
        
        //        configureNavigationBar()
        AccessLocationServices()
        configureUI()
        //        fetchUsers()
        fetchUserLocations()
        fetchCountDown()
        
        //        setBottomButtonControl()
        
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
        button.setTitle("Update", for: .normal)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alignImageAndTitleVertically()
        
        button.addTarget(self, action: #selector(clickUpdateButton), for: .touchUpInside)
        
        
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
        let attributedText = NSMutableAttributedString(string:  "All you need is", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        attributedText.append(NSMutableAttributedString(string: "\nStay at home", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black ]))
        
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
        
        button.addTarget(self, action: #selector(clickSafeActions), for: .touchUpInside)
        
        
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
        attributedText.append(NSMutableAttributedString(string: "\nGet quick update about lecture schedule", attributes:
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.black ]))
        attributedText.append(NSMutableAttributedString(string: "\nStaytune with us", attributes:
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.black ]))
        ImageText.attributedText = attributedText
        //        ImageText.backgroundColor = .gray
        
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
        //        button.setTitle("hello", for: .normal)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //        button.backgroundColor = .red
        
        button.addTarget(self, action: #selector(clickNoticeButton), for: .touchUpInside)
        
        
        return button
    }()
    
    private let seeMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See more", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.mainBlueTint, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(clickSeeMoreButton), for: .touchUpInside)
        
        
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
        let attributedText = NSMutableAttributedString(string:  "0", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35)])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    let deathsTextview: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string:  "0", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35)])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    let recoveredTextview: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string:  "0", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35)])
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
    
    private func configureUI(){
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
        //        bellIconStackView.backgroundColor = .orange
        
        bellIconStackView.addSubview(notificationImageView)
        //        bellIconStackView.addSubview(bellIconTextView)
        //        bellIconStackView.addSubview(nextButton)
        
        let bellTextStackView = UIView()
        bellTextStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bellTextStackView)
        //        bellTextStackView.backgroundColor = .gray
        
        //        bellIconStackView.addSubview(notificationImageView)
        bellTextStackView.addSubview(bellIconTextView)
        bellTextStackView.addSubview(nextButton)
        
        
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
            stayHomeImageContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            stayHomeImageContainerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 5),
            stayHomeImageContainerView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            stayHomeImageContainerView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.2),
            
            stayhomeImageView.centerYAnchor.constraint(equalTo: stayHomeImageContainerView.centerYAnchor),
            stayhomeImageView.heightAnchor.constraint(equalTo: stayHomeImageContainerView.heightAnchor, multiplier: 0.8),
            stayhomeImageView.widthAnchor.constraint(equalTo: stayHomeImageContainerView.widthAnchor, multiplier: 0.8, constant: -10),
            
            stayHomeTextContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stayHomeTextContainerView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -5),
            stayHomeTextContainerView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            stayHomeTextContainerView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.2),
            
            btnSafeAction.topAnchor.constraint(equalTo: stayHomeTextView.bottomAnchor, constant: 5),
            stayHomeTextView.centerYAnchor.constraint(equalTo: stayhomeImageView.centerYAnchor,constant: -15),
            
            
            bellIconStackView.topAnchor.constraint(equalTo: stayHomeImageContainerView.bottomAnchor),
            bellIconStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            //            bellIconStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bellIconStackView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.1),
            bellIconStackView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.2),
            
            
            bellTextStackView.topAnchor.constraint(equalTo: stayHomeImageContainerView.bottomAnchor),
            bellTextStackView.leadingAnchor.constraint(equalTo: bellIconStackView.trailingAnchor, constant: 10),
            //            bellTextStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bellTextStackView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.1),
            bellTextStackView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.8),
            
            
            
            notificationImageView.centerYAnchor.constraint(equalTo: bellIconStackView.centerYAnchor),
            notificationImageView.centerXAnchor.constraint(equalTo: bellIconStackView.centerXAnchor),
            notificationImageView.heightAnchor.constraint(equalTo: bellIconStackView.heightAnchor, multiplier: 0.6),
            notificationImageView.widthAnchor.constraint(equalTo: bellIconStackView.widthAnchor, multiplier: 0.6),
            
            bellIconTextView.leadingAnchor.constraint(equalTo: bellTextStackView.leadingAnchor, constant: 15 ),
            bellIconTextView.centerYAnchor.constraint(equalTo: bellTextStackView.centerYAnchor),
            
            nextButton.leadingAnchor.constraint(equalTo: bellTextStackView.trailingAnchor, constant: -15 ),
            nextButton.centerYAnchor.constraint(equalTo: bellTextStackView.centerYAnchor),
            
            
            
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
        //        coundDownControlStackView.backgroundColor = .orange
        
        
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
        
        let bottomControlStackView = UIStackView(arrangedSubviews: [homeButton,updateButton,settingsButton])
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlStackView)
        
        
        NSLayoutConstraint.activate([
            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        let mapStackView = UIView()
        mapStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapStackView)
        
        mapStackView.addSubview(mapView)
        mapView.frame = view.frame
        
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.userTrackingMode = .follow
        mapView.delegate = self
        
        NSLayoutConstraint.activate([
            
            mapStackView.topAnchor.constraint(equalTo: coundDownControlStackView.bottomAnchor, constant: 15),
            mapStackView.bottomAnchor.constraint(equalTo: bottomControlStackView.topAnchor, constant: -10),
            mapStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mapStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            mapStackView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.4),
            
            mapView.topAnchor.constraint(equalTo: mapStackView.topAnchor, constant: 15),
            mapView.bottomAnchor.constraint(equalTo: mapStackView.bottomAnchor, constant: -10),
            mapView.trailingAnchor.constraint(equalTo: mapStackView.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: mapStackView.leadingAnchor),
            //            mapView.bottomAnchor.constraint(equalTo: bottomControlStackView.topAnchor, constant: -10),
            
        ])
        
    }
    
    
    
    func fetchUserLocations() {
        var questionWeight = 0
        var temp = 0.0
        //        let user = Auth.auth().currentUser;
        //        guard let userId = user?.uid else { return }
        guard let location = locationManager?.location else { return }
        Service.shared.fetchUsersLocation(location: location) { (user) in
            guard let coordinate = user.location?.coordinate else { return }
            let annotation = UserAnnotation(uid: user.uid, coordinate: coordinate)
            
            questionWeight = user.questionFour + user.questionThree + user.questionTwo + user.questionOne
            temp = Double(user.temprature)!
            var userIsVisible: Bool {
                
                return self.mapView.annotations.contains { (annotation) -> Bool in
                    guard let userAnno = annotation as? UserAnnotation else { return false }
                    if userAnno.uid == user.uid {
                        if questionWeight >= 12 {
                            userAnno.updateAnnotationPosition(withCoordinate: coordinate)
                            if(!self.userNotificationArray.contains(user.uid)){
                                self.present(showMainAlert(title: "Warning", text: "Infected Person found around you"),animated: true, completion: nil)
                            }
                            
                            self.userNotificationArray.append(user.uid)
                        } else if temp > 37.5 {
                            userAnno.updateAnnotationPosition(withCoordinate: coordinate)
                            if(!self.userNotificationArray.contains(user.uid)){
                                self.present(showMainAlert(title: "Warning", text: "Infected Person found around you"),animated: true, completion: nil)
                            }
                            self.userNotificationArray.append(user.uid)
                        } else {
                            if let index = self.userNotificationArray.firstIndex(of: user.uid) {
                                self.userNotificationArray.remove(at: index)
                            }
                            self.mapView.removeAnnotation(annotation)
                        }
                        
                        
                        return true
                    }
                    return false
                }
            }
            if !userIsVisible {
                
                if questionWeight >= 12 {
                    self.mapView.addAnnotation(annotation)
                    self.present(showMainAlert(title: "Warning", text: "Infected Person found around you"),animated: true, completion: nil)
                    self.userNotificationArray.append(user.uid)
                } else if temp > 37.5 {
                    self.mapView.addAnnotation(annotation)
                    self.present(showMainAlert(title: "Warning", text: "Infected Person found around you"),animated: true, completion: nil)
                    self.userNotificationArray.append(user.uid)
                } else {
                    if let index = self.userNotificationArray.firstIndex(of: user.uid) {
                        self.userNotificationArray.remove(at: index)
                    }
                    self.mapView.removeAnnotation(annotation)
                }
                
            }
        }
    }
    func fetchUsers() {
        guard let location = locationManager?.location else { return }
        Service.shared.fetchUsersLocation(location: location) { (user) in
            guard let coordinate = user.location?.coordinate else { return }
            let annotation = UserAnnotation(uid: user.uid, coordinate: coordinate)
            
            var userIsVisible: Bool {
                
                return self.mapView.annotations.contains { (annotation) -> Bool in
                    guard let userAnno = annotation as? UserAnnotation else { return false }
                    
                    if userAnno.uid == user.uid {
                        userAnno.updateAnnotationPosition(withCoordinate: coordinate)
                        return true
                    }
                    
                    return false
                }
            }
            
            if !userIsVisible {
                self.mapView.addAnnotation(annotation)
            }
        }
        
    }
    
    
    func fetchCountDown(){
        Service.shared.fetchCoronaCount { (count) in
            self.infectedTextview.text = count.infected
            self.recoveredTextview.text = count.recovered
            self.deathsTextview.text = count.deaths
            
        }
    }

    
    //MARK: Functions
    
    @objc private func clickSafeActions() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let swipingViewController = SwipingViewController(collectionViewLayout: layout)
        navigationController?.pushViewController(swipingViewController, animated: true)
    }
    
    @objc private func clickSeeMoreButton() {
        let rootVC = FullMapViewController()
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc private func clickSettingsButton() {
        let rootVC = SettingsViewController()
        navigationController?.pushViewController(rootVC, animated: true)
    }
    @objc private func clickNoticeButton() {
        let rootVC = NotificationViewController()
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc private func clickUpdateButton() {
        let rootVC = UpdateViewController()
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    
    
    // MARK: API
    
    func checkUserLoggedIn(){
        if(Auth.auth().currentUser?.uid == nil){
            DispatchQueue.main.async {
                //                let nav = UINavigationController(rootViewController: LoginViewController())
                //                nav.modalPresentationStyle = .fullScreen
                //                self.present(nav, animated: true, completion: nil)
            }
        } else{
            print ("logged in")
        }
    }
    
    
}

// MARK: - LocationServices
extension HomeViewController {
    
    func  AccessLocationServices() {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedWhenInUse:
            locationManager?.requestAlwaysAuthorization()
        case .authorizedAlways:
            locationManager?.startUpdatingLocation()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        default:
            break
        }
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? UserAnnotation {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            view.image =  #imageLiteral(resourceName: "infected_icon")
            return view
        }
        
        return nil
    }
}

