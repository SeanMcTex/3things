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
}

fileprivate let appHasRunBeforeKey = "appHasRunBefore"
fileprivate let hasAskedAboutNotificationsKey = "hasAskedAboutNotificationsKey"
fileprivate let hasAcceptedNotificationsKey = "hasAcceptedNotificationsKey"
fileprivate let hasAskedAboutTodayWidgetKey = "hasAskedAboutTodayWidgetKey"
fileprivate let todayWidgetHasBeenDisplayedKey = "todayWidgetHasBeenDisplayedKey"

class UserDefaultsPreferencesManager: PreferencesManager {
    let userDefaults: UserDefaults
    
    init( userDefaults: UserDefaults ) {
        self.userDefaults = userDefaults
    }
    
    var appHasRunBefore: Bool {
        set( newValue ) {
            self.userDefaults.set( newValue, forKey: appHasRunBeforeKey )
        }
        get {
            return self.userDefaults.bool( forKey: appHasRunBeforeKey )
        }
    }
    
    var hasAskedAboutNotifications: Bool {
        set( newValue ) {
            self.userDefaults.set( newValue, forKey: hasAskedAboutNotificationsKey )
        }
        get {
            return self.userDefaults.bool( forKey: hasAskedAboutNotificationsKey )
        }
    }

    var hasAcceptedNotifications: Bool {
        set( newValue ) {
            self.userDefaults.set( newValue, forKey: hasAcceptedNotificationsKey )
        }
        get {
            return self.userDefaults.bool( forKey: hasAcceptedNotificationsKey )
        }
    }

    var hasAskedAboutTodayWidget: Bool {
        set( newValue ) {
            self.userDefaults.set( newValue, forKey: hasAskedAboutTodayWidgetKey )
        }
        get {
            return self.userDefaults.bool( forKey: hasAskedAboutTodayWidgetKey )
        }
    }

    var todayWidgetHasBeenDisplayed: Bool {
        set( newValue ) {
            self.userDefaults.set( newValue, forKey: todayWidgetHasBeenDisplayedKey )
        }
        get {
            return self.userDefaults.bool( forKey: todayWidgetHasBeenDisplayedKey )
        }
    }
}
