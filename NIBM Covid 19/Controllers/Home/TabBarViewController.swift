//
//  TabBarViewController.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 9/6/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth

class TabBarViewController: UIViewController {

    var tabBarCnt: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        createTabBarController()

    }
    
    
    func createTabBarController(){
        
        tabBarCnt = UITabBarController()
        tabBarCnt.tabBar.barStyle = UIBarStyle.black
    
        let firstViewController = HomeViewController()
//        firstViewController.title = "Home"
//        firstViewController.view.backgroundColor = .red
        
        let secondViewController = SettingsViewController()
//        secondViewController.title = "Update"
//        secondViewController.view.backgroundColor = .yellow
        
        tabBarCnt.viewControllers = [firstViewController,secondViewController]
        self.view.addSubview(tabBarCnt.view)
        
        
    }
    
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
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
