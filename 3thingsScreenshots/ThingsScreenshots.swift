//
//  _thingsScreenshots.swift
//  3thingsScreenshots
//
//  Created by Sean Mc Mains on 1/25/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import XCTest



class ThingsScreenshots: XCTestCase {
    
    var app: XCUIApplication = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        setupSnapshot( app )
        app.launchArguments += ["UI-Testing"]
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateScreenshots() {
                
        let goal1fieldTextField = app.textFields["goal1Field"]
        goal1fieldTextField.clearAndEnterText(text: "Work Out\n")
        
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
