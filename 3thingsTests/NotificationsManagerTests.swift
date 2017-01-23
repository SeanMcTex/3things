//
//  NotificationsManagerTests.swift
//  3things
//
//  Created by Sean Mc Mains on 1/19/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import XCTest
@testable import _things

class NotificationsManagerTests: XCTestCase {
    
    private var sut: NotificationsManager?
    
    override func setUp() {
        super.setUp()
        
        self.sut = NotificationsManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFirstReminderDateIsTodayWhenGoalsAreNotCurrent() {
        if let firstReminder = sut?.todaysReminderDate() {
            let isToday = Calendar.current.isDateInToday( firstReminder )
            XCTAssert( isToday )
        } else {
            XCTFail("Couldn't get first reminder date")
        }
    }
    
}
