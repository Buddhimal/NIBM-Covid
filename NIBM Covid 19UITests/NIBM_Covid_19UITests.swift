//
//  NIBM_Covid_19UITests.swift
//  NIBM Covid 19UITests
//
//  Created by Buddhimal Gunasekara on 9/8/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import XCTest

class NIBM_Covid_19UITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testHome(){
        
        
        let app = XCUIApplication()
        app.launch()
        app.children(matching: .window).element(boundBy: 0).tap()
        
        let okayButton = app.alerts["Warning"].scrollViews.otherElements.buttons["Okay"]
        okayButton.tap()
        app.buttons["See more"].tap()
        okayButton.tap()
        app.navigationBars["Danger Areas"].buttons["Home"].tap()
        app.buttons["Settings"].tap()
        app.buttons["Profile"].tap()
        app.navigationBars["Profile"].buttons["Settings"].tap()
        app.navigationBars["Settings"].buttons["Home"].tap()
        
                        
    }
}
