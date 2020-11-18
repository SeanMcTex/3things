//
//  AppDelegate.swift
//  3things
//
//  Created by Sean Mc Mains on 1/5/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let appScopeFactory: AppScopeFactory
    
    override init() {
        let extensionScopeFactory = ProductionExtensionScopeFactory( domain: standardDomain )
        self.appScopeFactory = ProductionAppScopeFactory( extensionScopeFactory: extensionScopeFactory )
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setStateForUITesting()
        return true
    }
    
    static var isUITestingEnabled: Bool {
        return ProcessInfo.processInfo.arguments.contains("UI-Testing")
    }
    
    private func setStateForUITesting() {
        if AppDelegate.isUITestingEnabled {
            self.appScopeFactory.goalsManager().clearGoals()
            self.appScopeFactory.onboardingManager().enabled = false
        }
    }
    
}
