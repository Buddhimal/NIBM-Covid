//
//  AppDelegate.swift
//  NIBM Covid 19
//
//  Created by Buddhimal Gunasekara on 9/8/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


     var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            window = UIWindow()
            FirebaseApp.configure()
            window?.makeKeyAndVisible()
            
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]){
                (granted, error) in
            }

            
//            window?.rootViewController = UINavigationController(rootViewController: FullMapViewController())
            window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
            
            return true
        }

        // MARK: UISceneSession Lifecycle

    }

