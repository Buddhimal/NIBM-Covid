//
//  Notification.swift
//  NIBM Covid 19
//
//  Created by Buddhimal Gunasekara on 9/13/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import CoreLocation

//struct Notification {
//    let title: String
//    let text: String
//    let created: String
//    let uid: String
//
//    init(uid: String, dictionary: [String: Any]) {
//        self.uid = uid
//        self.title = dictionary["title"] as? String ?? ""
//        self.text = dictionary["text"] as? String ?? ""
//        self.created = dictionary["created"] as? String ?? ""
//
//    }
//}

struct Notification {
    var title: String?
    var text: String?
    var created: String?
    
    init(title: String, text: String, created: String) {
        self.title = title
        self.text = text
        self.created = created
    }
}

