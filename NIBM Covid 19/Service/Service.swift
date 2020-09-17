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
let REF_CORONA_COUNT = DB_REF.child("corona-details")

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
        REF_USERS.observe(.value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let user = User(uid: child.key, dictionary: child.value as! [String : Any])
                completion(user)
                
            }
            
            
        }
    }
 
    func updateUserWithImage(imageUrl: String, username: String, indexNo:String, country: String){
           return REF_USERS.child(loginUserId!).updateChildValues(["image":imageUrl, "firstName":username,"indexNo":indexNo,"country":country])
       }
    
    func fetchCoronaCount(completion: @escaping(CoronaCount) -> Void){
        REF_CORONA_COUNT.observe(.value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let dict = child.value as? [String : AnyObject] ?? [:]
                
//                print("dict")
                print(String(describing: dict["infected"]!))
                
                let cCount = CoronaCount(infected: String(describing: dict["infected"]!) , deaths: String(describing: dict["deaths"]!), recovered: String(describing: dict["recovered"]!) )
//                print(cCount)
                completion(cCount)
                
            }
//            print(count["infected"])


            
        }
    }

    
    
}
