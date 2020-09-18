//
//  NIBM_Covid_19Tests.swift
//  NIBM Covid 19Tests
//
//  Created by Buddhimal Gunasekara on 9/8/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import XCTest
@testable import NIBM_Covid_19

class NIBM_Covid_19Tests: XCTestCase {

    func testLogin(){
        let clz = LoginViewController()
        let result = clz.validateLogin()
        
        XCTAssertEqual(result,false)
    }
    
}
