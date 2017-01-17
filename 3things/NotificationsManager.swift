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
    
    func getNotificationPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in return }
    }
    
    func scheduleReminder() {
        let content = UNMutableNotificationContent()
        content.title = "Set Today's Goals"
        content.body = "It's time to decide what three things are most important for you to accomplish today"
        content.sound = UNNotificationSound(named: "3things-alert.caf")
        
        var dateComponents = DateComponents()
        dateComponents.hour = 7
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: notificationIdentifier,
                                            content: content,
                                            trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { ( error ) in
            if let error = error {
                NSLog("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
}
