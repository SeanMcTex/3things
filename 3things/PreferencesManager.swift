//
//  PreferencesManager.swift
//  3things
//
//  Created by Sean Mc Mains on 2/6/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation

protocol PreferencesManager: class {
    var appHasRunBefore: Bool {get set}
    var hasAskedAboutNotifications: Bool {get set}
    var hasAcceptedNotifications: Bool {get set}
    var hasAskedAboutTodayWidget: Bool {get set}
    var todayWidgetHasBeenDisplayed: Bool {get set}
    var settings: Settings {get set}
}

private let appHasRunBeforeKey = "appHasRunBefore"
private let hasAskedAboutNotificationsKey = "hasAskedAboutNotificationsKey"
private let hasAcceptedNotificationsKey = "hasAcceptedNotificationsKey"
private let hasAskedAboutTodayWidgetKey = "hasAskedAboutTodayWidgetKey"
private let todayWidgetHasBeenDisplayedKey = "todayWidgetHasBeenDisplayedKey"
private let reminderTimeKey = "reminderTimeKey"

class UserDefaultsPreferencesManager: PreferencesManager {
    let userDefaults: UserDefaults
    
    init( userDefaults: UserDefaults ) {
        self.userDefaults = userDefaults
    }
    
    var appHasRunBefore: Bool {
        get {
            return self.userDefaults.bool( forKey: appHasRunBeforeKey )
        }
        set( newValue ) {
            self.userDefaults.set( newValue, forKey: appHasRunBeforeKey )
        }
    }
    
    var hasAskedAboutNotifications: Bool {
        get {
            return self.userDefaults.bool( forKey: hasAskedAboutNotificationsKey )
        }
        set( newValue ) {
            self.userDefaults.set( newValue, forKey: hasAskedAboutNotificationsKey )
        }
    }

    var hasAcceptedNotifications: Bool {
        get {
            return self.userDefaults.bool( forKey: hasAcceptedNotificationsKey )
        }
        set( newValue ) {
            self.userDefaults.set( newValue, forKey: hasAcceptedNotificationsKey )
        }
    }

    var hasAskedAboutTodayWidget: Bool {
        get {
            return self.userDefaults.bool( forKey: hasAskedAboutTodayWidgetKey )
        }
        set( newValue ) {
            self.userDefaults.set( newValue, forKey: hasAskedAboutTodayWidgetKey )
        }
    }

    var todayWidgetHasBeenDisplayed: Bool {
        get {
            return self.userDefaults.bool( forKey: todayWidgetHasBeenDisplayedKey )
        }
        set( newValue ) {
            self.userDefaults.set( newValue, forKey: todayWidgetHasBeenDisplayedKey )
        }
    }
    
    var settings: Settings {
        get {
            let settings = Settings()
            
            if let reminderTime = self.userDefaults.object(forKey: reminderTimeKey ) as? Date {
                settings.reminderTime = reminderTime
            }
            
            return settings
        }
        set( newValue ) {
            self.userDefaults.set( newValue.reminderTime, forKey: reminderTimeKey )
        }
    }
}
