//
//  TestHomeViewController.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 9/6/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class TestHomeViewController: UIViewController {

    var closeLabel : UILabel!
    var imageView : UIImageView!
    var ImageText : UILabel!
    var viewOne : UIView!
    var viewTwo : UIView!
    var btnSafeActions : UIButton!
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = . white
        
        
        viewOne = UIView()
//        viewOne.backgroundColor = .red
        viewOne.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewOne)
        
        viewTwo = UIView()
//        viewTwo.backgroundColor = .blue
        viewTwo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewTwo)
        
        
        imageView = UIImageView(image: #imageLiteral(resourceName: "stay_home") )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        viewOne.addSubview(imageView)
        
        
        ImageText = UILabel()
        ImageText.translatesAutoresizingMaskIntoConstraints = false
        ImageText.numberOfLines = 3
//        ImageText.lineBreakMode = NSLineBreakMode.byWordWrapping
//        ImageText.textAlignment = NSTextAlignment.left
        
        let attributedText = NSMutableAttributedString(string:  "All you need is", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSMutableAttributedString(string: "\nstay at home", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.black ]))
        
        ImageText.attributedText = attributedText

        viewTwo.addSubview(ImageText)
        
        
        btnSafeActions = UIButton(type: .system)
        btnSafeActions.setTitle("Safe actions  ", for: .normal)
        btnSafeActions.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btnSafeActions.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btnSafeActions.setTitleColor(UIColor.mainBlueTint, for: .normal)
        btnSafeActions.translatesAutoresizingMaskIntoConstraints = false
//        btnSafeActions.contentHorizontalAlignment = .right
        btnSafeActions.semanticContentAttribute = .forceRightToLeft
//        btnSafeActions.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:  20)
        


        
        viewTwo.addSubview(btnSafeActions)
        
        
        
        
        NSLayoutConstraint.activate([
            viewOne.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            viewOne.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 5),
            viewOne.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            viewOne.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.2),
            
            imageView.centerYAnchor.constraint(equalTo: viewOne.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: viewOne.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: viewOne.heightAnchor, multiplier: 0.8),
            imageView.widthAnchor.constraint(equalTo: viewOne.widthAnchor, multiplier: 0.8),
            

            
            viewTwo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            viewTwo.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -5),
            viewTwo.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            viewTwo.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.2),
            
            ImageText.centerYAnchor.constraint(equalTo: viewOne.centerYAnchor),
            btnSafeActions.topAnchor.constraint(equalTo: ImageText.bottomAnchor, constant: 5),

            
        ])
        
        
//        closeLabel = UILabel()
//        closeLabel.translatesAutoresizingMaskIntoConstraints = false
//        closeLabel.textAlignment = .right
//        closeLabel.text = "Close"
//        view.addSubview(closeLabel)
//
//
//        imageView = UIImageView(image: #imageLiteral(resourceName: "stay_home") )
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        view.addSubview(imageView)
//
//        ImageText = UILabel()
//        ImageText.translatesAutoresizingMaskIntoConstraints = false
////        ImageText.textAlignment = .right
////        ImageText.text = "Close"
//        ImageText.lineBreakMode = NSLineBreakMode.byWordWrapping
//        ImageText.textAlignment = NSTextAlignment.left
//
////        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
////        button.titleLabel?.textAlignment = NSTextAlignment.center
//
//
//        let attributedText = NSMutableAttributedString(string:  "All you need is stay at home", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
//
//        attributedText.append(NSMutableAttributedString(string: "\nstay at home", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: UIColor.black ]))
//
//        ImageText.attributedText = attributedText
//        view.addSubview(ImageText)
//
//
//
//        NSLayoutConstraint.activate([
//            closeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
//            closeLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//
//            imageView.topAnchor.constraint(equalTo: closeLabel.bottomAnchor),
//            imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
//            imageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
//            imageView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.33),
//
//            ImageText.topAnchor.constraint(equalTo: closeLabel.bottomAnchor),
////            imageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
//            ImageText.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            ImageText.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4),
//            ImageText.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
//        ])
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Test Home"
//        view.backgroundColor = .white

    }
    

}
