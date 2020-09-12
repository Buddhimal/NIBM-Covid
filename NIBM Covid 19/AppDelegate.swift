//
//  AppDelegate.swift
//  NIBM Covid 19
//
//  Created by Buddhimal Gunasekara on 9/8/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


     var window: UIWindow?


        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            window = UIWindow()
            FirebaseApp.configure()
            window?.makeKeyAndVisible()
//            window?.rootViewController = UINavigationController(rootViewController: SurveyFirstViewController())
//            window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
//            window?.rootViewController = UINavigationController(rootViewController: SettingsViewController())
            window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
//            window?.rootViewController = UINavigationController(rootViewController: ViewController())
//            window?.rootViewController = UINavigationController(rootViewController: UpdateViewController())

            
            return true
        }

        // MARK: UISceneSession Lifecycle

    }

