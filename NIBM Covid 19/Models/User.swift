//
//  User.swift
//  NIBM Covid19
//
//  Created by Buddhimal Gunasekara on 9/10/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import CoreLocation

enum AccountType: Int {
    case student
    case teacher
}

struct User {
    let firstName: String
    let lastName: String
    let email: String
    var role: AccountType!
    var location: CLLocation?
    let uid: String
    let questionOne: Int
    let questionTwo: Int
    let questionThree: Int
    let questionFour: Int
    let temprature: String
    let profileImageUrl: String
    let country: String
    let indexNo: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.questionOne = dictionary["surveyOne"] as? Int ?? 0
        self.questionTwo = dictionary["surveyTwo"] as? Int ?? 0
        self.questionThree = dictionary["surveyThree"] as? Int ?? 0
        self.questionFour = dictionary["surveyFour"] as? Int ?? 0
        self.temprature = dictionary["bodyTemperature"] as? String ?? "0.0"
        self.profileImageUrl = dictionary["image"] as? String ?? ""
        self.country = dictionary["country"] as? String ?? ""
        self.indexNo = dictionary["indexNo"] as? String ?? ""
        
        if let index = dictionary["role"] as? Int {
            self.role = AccountType(rawValue: index)
        }
    }
}
