//
//  NotificationsManagerTests.swift
//  3things
//
//  Created by Sean Mc Mains on 1/19/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import XCTest
import UserNotifications
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
    
    func testSchedulingRemindersResultsIn7Notifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        
        sut?.scheduleReminder(areTodaysGoalsSet: true)
        
        let notificationExpectation = self.expectation(description: "7 notifications scheduled")
        notificationCenter.getPendingNotificationRequests { (requests) in
            if requests.count == 7 {
                notificationExpectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
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
