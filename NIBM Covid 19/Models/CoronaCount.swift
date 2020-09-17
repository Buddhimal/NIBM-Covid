//
//  CoronaCount.swift
//  NIBM Covid 19
//
//  Created by Buddhimal gunasekara on 9/17/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import CoreLocation

struct CoronaCount {
    var infected: String?
    var deaths: String?
    var recovered: String?
    
    init(infected: String, deaths: String, recovered: String) {
        self.infected = infected as? String ?? "0"
        self.deaths = deaths as? String ?? "0"
        self.recovered = recovered as? String ?? "0"
    }
}

