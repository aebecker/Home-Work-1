//
//  Home_Work_1UITests.swift
//  Home Work 1UITests
//
//  Created by Anthony Becker on 12/21/18.
//  Copyright © 2018 Anthony Becker. All rights reserved.
//

import XCTest

class Home_Work_1UITests: XCTestCase {

    var app:XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUIFlow() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let enterSearchTextField = app.tables["Empty list"].searchFields[" Search Here....."]
        enterSearchTextField.tap()
        enterSearchTextField.typeText("Star Wars")

        Thread.sleep(forTimeInterval:1.0)
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["VADER EPISODE 1: SHARDS OF THE PAST - A STAR WARS THEORY FAN-FILM"]/*[[".cells.staticTexts[\"VADER EPISODE 1: SHARDS OF THE PAST - A STAR WARS THEORY FAN-FILM\"]",".staticTexts[\"VADER EPISODE 1: SHARDS OF THE PAST - A STAR WARS THEORY FAN-FILM\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        Thread.sleep(forTimeInterval:1.0)

        app.scrollViews.otherElements.webViews/*@START_MENU_TOKEN@*/.buttons["Play"]/*[[".otherElements[\"VADER EPISODE 1: SHARDS OF THE PAST - A STAR WARS THEORY FAN-FILM - YouTube\"]",".otherElements[\"YouTube Video Player\"].buttons[\"Play\"]",".buttons[\"Play\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Video Detail"].buttons["Top 10 List"].tap()
        app.tables.buttons["Clear text"].tap()
        
    }

}
