//
//  AppScopeFactory.swift
//  3things
//
//  Created by Sean Mc Mains on 2/6/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation

protocol AppScopeFactory: ExtensionScopeFactory {
    func notificationsManager() -> NotificationsManager
    func quotesManager() -> QuotesManager
    func onboardingManager() -> OnboardingManager
    func sharingManager() -> SharingManager
}

struct ProductionAppScopeFactory: AppScopeFactory {
    
    private let extensionScopeFactory: ExtensionScopeFactory
    
    private let onboarding: OnboardingManager
    private let notification: NotificationsManager
    private let quotes: QuotesManager
    private let sharing: SharingManager
    
    init( extensionScopeFactory: ExtensionScopeFactory ) {
        self.extensionScopeFactory = extensionScopeFactory
        
        let preferencesManager = extensionScopeFactory.preferencesManager()
        self.onboarding = OnboardingManager( preferencesManager: preferencesManager )
        self.notification = NotificationsManager()
        self.quotes = QuotesManager()
        self.sharing = SharingManager()
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
    
    func sharingManager() -> SharingManager {
        return self.sharing
    }
    
    // MARK: - Extension Scope Factory Passthrough
    func goalsManager() -> GoalsManager {
        return extensionScopeFactory.goalsManager()
    }
    
    func audioManager() -> AudioManager {
        return extensionScopeFactory.audioManager()
    }
    
    func preferencesManager() -> PreferencesManager {
        return extensionScopeFactory.preferencesManager()
    }
}
