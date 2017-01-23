//
//  NotificationsManager.swift
//  3things
//
//  Created by Sean Mc Mains on 1/10/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationsManager {
    private let notificationIdentifier = "morningReminder"
    private let numberOfNotificationsToSchedule = 7
    
    public func getNotificationPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in return }
    }
    
    public func scheduleReminder( areTodaysGoalsSet: Bool ) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        for reminderDate in todaysReminderDate().next(days: numberOfNotificationsToSchedule,
                                                      includeStartDate: areTodaysGoalsSet) {
            
            let content = normalNotificationContent()
            let trigger = UNCalendarNotificationTrigger(dateMatching: reminderDate.components(),
                                                        repeats: false)
            let request = UNNotificationRequest(identifier: notificationIdentifier,
                                                content: content,
                                                trigger: trigger)
            
            notificationCenter.add( request ) { ( error ) in
                if let error = error {
                    NSLog("Error scheduling notification: \(error.localizedDescription)")
                }
            }
        }
    }
    
    internal func normalNotificationContent() -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("Set Today's Goals", comment: "Reminder alert title")
        content.body = NSLocalizedString("It's time to decide what three" +
            "things are most important for you to accomplish today",
                                         comment: "Reminder alert body")
        content.sound = UNNotificationSound(named: "3things-alert.caf")
        
        return content
    }
    
    internal func finalNotificationContent() -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("Final Reminder", comment: "Final reminder alert title")
        content.body = NSLocalizedString("You haven't set goals for \(numberOfNotificationsToSchedule) days," +
            "so we'll turn off reminders for now.",
                                         comment: "Final reminder alert body")
        content.sound = UNNotificationSound(named: "3things-alert.caf")
        
        return content
    }
    
    internal func todaysReminderDate() -> Date {
        var dateComponents = Date().components()
        dateComponents.hour = 7
        dateComponents.minute = 0
        
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
}
