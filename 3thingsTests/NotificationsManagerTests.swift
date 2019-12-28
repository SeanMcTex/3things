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
        
        sut?.scheduleReminder(areTodaysGoalsSet: true, reminderTime: Date.todayAtTime(hour: 7, minute: 0))
        
        let notificationExpectation = self.expectation(description: "7 notifications scheduled")
        notificationCenter.getPendingNotificationRequests { (requests) in
            if requests.count == 7 {
                notificationExpectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testRemindersAreAtSpecifiedTime() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        
        sut?.scheduleReminder(areTodaysGoalsSet: true, reminderTime: Date.todayAtTime(hour: 13, minute: 15))
        
        let notificationExpectation = self.expectation(description: "notification scheduled on time")
        notificationCenter.getPendingNotificationRequests { (requests) in
            if let request = requests.first {
                if let trigger = request.trigger as? UNCalendarNotificationTrigger {
                    XCTAssertEqual(trigger.dateComponents.hour, 13)
                    XCTAssertEqual(trigger.dateComponents.minute, 15)
                    notificationExpectation.fulfill()
                } else {
                    XCTFail("Notification of incorrect type")
                }
            }
        }
        
        self.waitForExpectations(timeout: 1.0, handler: nil)

    }
    
    func testFirstReminderDateIsTodayWhenGoalsAreNotCurrent() {
        let firstReminder = Date.todayAtTime(hour: 7, minute: 0)
        let isToday = Calendar.current.isDateInToday( firstReminder )
        XCTAssert( isToday )
    }
        
        
}
