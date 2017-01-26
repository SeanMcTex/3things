//
//  _thingsScreenshots.swift
//  3thingsScreenshots
//
//  Created by Sean Mc Mains on 1/25/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import XCTest



class ThingsScreenshots: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        setupSnapshot( app )
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateScreenshots() {
        
        let app = XCUIApplication()

        let goal1fieldTextField = app.textFields["goal1Field"]
        goal1fieldTextField.tap()
        goal1fieldTextField.buttons["Clear text"].tap()
        goal1fieldTextField.typeText("Work Out\n")
        
        let goal2fieldTextField = app.textFields["goal2Field"]
        goal2fieldTextField.tap()
        goal2fieldTextField.typeText("Call Mom\n")
        
        snapshot("1EditingInProgress")
        
        let goal3fieldTextField = app.textFields["goal3Field"]
        goal3fieldTextField.tap()
        goal3fieldTextField.typeText("Finish Presentation\n")
        
        snapshot("2GoalsEnteredSomeItemsSelected")
    }
    
}
