//
//  PreferencesManagerTests.swift
//  3things
//
//  Created by Sean Mc Mains on 2/7/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import XCTest
@testable import _things

class PreferencesManagerTests: XCTestCase {
    
    private var sut: PreferencesManager?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let userDefaults = UserDefaults(suiteName: "testUserDefaults")!
        self.sut = UserDefaultsPreferencesManager( userDefaults: userDefaults )
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDidRunBefore() {
        sut?.appHasRunBefore = true
        XCTAssertTrue( sut?.appHasRunBefore ?? false )
        
        sut?.appHasRunBefore = false
        XCTAssertFalse( sut?.appHasRunBefore ?? true )
    }

    func testDidAskAboutNotification() {
        sut?.hasAskedAboutNotifications = true
        XCTAssertTrue( sut?.hasAskedAboutNotifications ?? false )
        
        sut?.hasAskedAboutNotifications = false
        XCTAssertFalse( sut?.hasAskedAboutNotifications ?? true )
    }
    
    func testDidAcceptNotification() {
        sut?.hasAcceptedNotifications = true
        XCTAssertTrue( sut?.hasAcceptedNotifications ?? false )
        
        sut?.hasAcceptedNotifications = false
        XCTAssertFalse( sut?.hasAcceptedNotifications ?? true )
    }
    
    func testDidAskAboutTodayWidget() {
        sut?.hasAskedAboutTodayWidget = true
        XCTAssertTrue( sut?.hasAskedAboutTodayWidget ?? false )
        
        sut?.hasAskedAboutTodayWidget = false
        XCTAssertFalse( sut?.hasAskedAboutTodayWidget ?? true )
    }

    func testTodayWidgetHasBeenDisplayed() {
        sut?.todayWidgetHasBeenDisplayed = true
        XCTAssertTrue( sut?.todayWidgetHasBeenDisplayed ?? false )
        
        sut?.todayWidgetHasBeenDisplayed = false
        XCTAssertFalse( sut?.todayWidgetHasBeenDisplayed ?? true )
    }
}
