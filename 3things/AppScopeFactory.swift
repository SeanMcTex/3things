//
//  AppScopeFactory.swift
//  3things
//
//  Created by Sean Mc Mains on 2/6/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation

protocol AppScopeFactory {
    func notificationsManager() -> NotificationsManager
    func quotesManager() -> QuotesManager
    func onboardingManager() -> OnboardingManager
}

struct ProductionAppScopeFactory: AppScopeFactory {
    
    private let extensionScopeFactory: ExtensionScopeFactory
    
    private let onboarding: OnboardingManager
    private let notification: NotificationsManager
    private let quotes: QuotesManager
    
    init( extensionScopeFactory: ExtensionScopeFactory ) {
        self.extensionScopeFactory = extensionScopeFactory
        
        let preferencesManager = extensionScopeFactory.preferencesManager()
        self.onboarding = OnboardingManager( preferencesManager: preferencesManager )
        self.notification = NotificationsManager()
        self.quotes = QuotesManager()
    }
        
    func notificationsManager() -> NotificationsManager {
        return self.notification
    }
    
    func quotesManager() -> QuotesManager {
        return self.quotes
    }
    
    func onboardingManager() -> OnboardingManager {
        return self.onboarding
    }
}
