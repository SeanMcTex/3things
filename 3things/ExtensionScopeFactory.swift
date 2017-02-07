//
//  ExtensionScopeFactory.swift
//  3things
//
//  Created by Sean Mc Mains on 2/7/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation

protocol ExtensionScopeFactory {
    func goalsManager() -> GoalsManager
    func audioManager() -> AudioManager
    func preferencesManager() -> PreferencesManager
}

struct ProductionExtensionScopeFactory: ExtensionScopeFactory {
    let userDefaults: UserDefaults
    
    private let preferences: PreferencesManager
    private let goals: GoalsManager
    private let audio: AudioManager
    
    init( domain: String ) {
        self.userDefaults = UserDefaults( suiteName: domain )!
        self.preferences = UserDefaultsPreferencesManager( userDefaults: userDefaults )
        self.goals = GoalsManager( domain: domain )
        self.audio = AudioManager()
    }
    
    func goalsManager() -> GoalsManager {
        return self.goals
    }
    
    func audioManager() -> AudioManager {
        return self.audio
    }
    
    func preferencesManager() -> PreferencesManager {
        return self.preferences
    }
}
