//
//  SurveyResult.swift
//  NIBM Covid 19
//
//  Created by Buddhimal Gunasekara on 9/18/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import Foundation

struct SurveyResult {
    var name: String?
    var q1: String?
    var q2: String?
    var q3: String?
    var q4: String?
    
    
    init(name: String, q1: String, q2: String, q3: String, q4: String) {
        
        self.name = name
        self.q1 = q1
        self.q2 = q2
        self.q3 = q3
        self.q4 = q4
    }
}
