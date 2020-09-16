//
//  Service.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 9/10/20.
//  Copyright © 2020 NIBM. All rights reserved.

//

import Firebase
import CoreLocation
import GeoFire

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_NOTIFICATIONS = DB_REF.child("notifications")
let REF_USER_LOCATIONS = DB_REF.child("user-locations")
let REF_TRIPS = DB_REF.child("trips")

// MARK: - SharedService

struct Service {
    static let shared = Service()
    private let locationManager = LocationHandler.shared.locationManager
    let loginUserId = Auth.auth().currentUser?.uid
    
    

    
    func fetchUserData(uid: String, completion: @escaping(User) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let uid = snapshot.key
//            print("user.........")
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
    
    func fetchUsersLocation(location: CLLocation, completion: @escaping(User) -> Void) {
        let geoFire = GeoFire(firebaseRef: REF_USER_LOCATIONS)
        
        REF_USER_LOCATIONS.observe(.value) { (snapshot) in
            geoFire.query(at: location, withRadius: 50).observe(.keyEntered, with: { (uid, location) in
                self.fetchUserData(uid: uid) { (user) in
                    var usr = user
                    usr.location = location
                    completion(usr)
                }
            })
        }
    }
    
    func fetchAllUsers(completion: @escaping(User) -> Void) {
        
//        let geoFire = GeoFire(firebaseRef: REF_USER_LOCATIONS)
//        guard let location = locationManager?.location else { return }
        
        REF_USERS.observe(.value) { (snapshot) in
//            guard let dictionary = snapshot.value as? [String: Any] else { return }
//            let uid = snapshot.key
//            print("user.........Fetch")
//            print(dictionary)
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
//                let dict = child.value as? [String : AnyObject] ?? [:]
                
                let user = User(uid: child.key, dictionary: child.value as! [String : Any])
                completion(user)

                
//                REF_USER_LOCATIONS.child(child.key).observeSingleEvent(of: .value) { (snapshot) in
//                    geoFire.query(at: location, withRadius: 50).observe(.keyEntered, with: { (uid, location) in
//
//
//
////                      print("dict")
////                        print(dict)
////                        print("usrLocation.....")
////                        print(uid)
////                        print(location)
//
//                    })
//                }
//                self.notificationArr.append(Notification( title: dict["title"] as! String, text: dict["text"] as! String, created: dict["created"] as! String))

            }
            
//            REF_USER_LOCATIONS.child("1FZvOwbcmmTkbefC2NNGTFcyOYq1").observeSingleEvent(of: .value) { (snapshot) in
//                geoFire.query(at: location, withRadius: 50).observe(.keyEntered, with: { (uid, location) in
//
//
//                    print("usrLocation.....")
//                    print(uid)
//                    print(location)
//
//                })
//            }
            
//            let user = User(uid: uid, dictionary: dictionary)
//            print(user)
//            completion(user)
        }
    }
    
    //    func fetchNotifications(uid: String, completion: @escaping(Notification) -> Void) {
    //        REF_NOTIFICATIONS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
    //            self.fetchNotifications(uid: uid) { (notification) in
    //                guard let dictionary = snapshot.value as? [String: Any] else { return }
    //                let uid = snapshot.key
    //                let notifi = Notification(uid: uid, dictionary: dictionary)
    //                completion(notifi)
    //
    //            }
    //        }
    //    }
    
    
    
    func updateUserWithImage(imageUrl: String, username: String, indexNo:String, country: String){
        
//        let user = Auth.auth().currentUser;
        
//        guard let userId = user?.uid else { return }
        
           return REF_USERS.child(loginUserId!).updateChildValues(["image":imageUrl, "firstName":username,"indexNo":indexNo,"country":country])
       }
    
    
}
