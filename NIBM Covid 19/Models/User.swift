//
//  User.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 9/10/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import CoreLocation

enum AccountType: Int {
    case passenger
    case driver
}

struct User {
    let firstName: String
    let lastName: String
    let email: String
    var role: AccountType!
    var location: CLLocation?
    let uid: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["firstName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        
        if let index = dictionary["accountType"] as? Int {
            self.role = AccountType(rawValue: index)
        }
    }
}
