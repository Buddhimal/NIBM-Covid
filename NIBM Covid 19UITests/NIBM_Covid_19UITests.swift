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
//        let okayButton = app.alerts["Warning"].scrollViews.otherElements.buttons["Okay"]
//        okayButton.tap()
        app.buttons["Safe actions  "].tap()
        
        let nextButton = app.buttons["NEXT"]
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        
        let prevButton = app.buttons["PREV"]
        prevButton.tap()
        prevButton.tap()
        prevButton.tap()
        
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()

        
        prevButton.tap()
        prevButton.tap()
        prevButton.tap()
        
        app.navigationBars["Safe Actions"].buttons["Home"].tap()
        app.buttons["Forward"].tap()
        app.navigationBars["All News"].buttons["Home"].tap()
        app.buttons["See more"].tap()
                        
    }
    
    func testLogin(){
        
        let app = XCUIApplication()
        app.launch()

        app.buttons["Settings"].tap()
        app.buttons["LOGOUT"].tap()
        app.textFields["Email"].tap()
        
        let aKey = app.keys["A"]
        aKey.tap()
        
        let moreKey = app.keys["more"]
        moreKey.tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["@"]/*[[".keyboards.keys[\"@\"]",".keys[\"@\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let moreKey2 = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"letters\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        moreKey2.tap()
        
        let gKey = app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        gKey.tap()
        
        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        app.keys["a"].tap()
        
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        moreKey.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["."]/*[[".keyboards.keys[\".\"]",".keys[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        moreKey2.tap()
        
        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        mKey.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).tap()
        app.secureTextFields["Password"].tap()
        moreKey.tap()
        
        let key3 = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key3.tap()
        
        let key4 = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key4.tap()
        
        let key5 = app/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key5.tap()
        
        let key6 = app/*@START_MENU_TOKEN@*/.keys["4"]/*[[".keyboards.keys[\"4\"]",".keys[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key6.tap()
        
        let key7 = app/*@START_MENU_TOKEN@*/.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key7.tap()
        
        let key8 = app/*@START_MENU_TOKEN@*/.keys["6"]/*[[".keyboards.keys[\"6\"]",".keys[\"6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key8.tap()
        app.buttons["Log In"].tap()
        
    }
    
    func testNotifications(){
        
        
        let app = XCUIApplication()
        app.launch()

        app.buttons["Forward"].tap()
//        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Hi")/*[[".cells.containing(.staticText, identifier:\"Sep 19,2020\")",".cells.containing(.staticText, identifier:\"Hi\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Hello"].swipeDown()
        app.navigationBars["All News"].buttons["Home"].tap()
        app.buttons["Update"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).buttons["Forward"].tap()
        app.navigationBars["New Notification"].buttons["Update"].tap()
        app.navigationBars["Update"].buttons["Home"].tap()
                        
        
    }
    
    func testProfile(){
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["Settings"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.swipeDown()
        element.swipeUp()
        element.swipeUp()
        element.swipeUp()
        element.swipeUp()
        element.swipeUp()
        element.swipeDown()
        element.swipeDown()
        element.swipeDown()
        element.swipeDown()
        element.swipeDown()
        element/*@START_MENU_TOKEN@*/.swipeLeft()/*[[".swipeUp()",".swipeLeft()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        element.press(forDuration: 2.8);
        app.buttons["Profile"].tap()
        
        let indexNumberTextField = app.textFields["Index Number"]
        indexNumberTextField.tap()
        
        let countryTextField = app.textFields["Country"]
        countryTextField.tap()
        indexNumberTextField.tap()
        countryTextField.tap()
        app.navigationBars["Profile"].buttons["Settings"].tap()
        app.navigationBars["Settings"].buttons["Home"].tap()
        
        
    }
    
}
