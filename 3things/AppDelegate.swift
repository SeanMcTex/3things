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
    
    let extensionScopeFactory: ExtensionScopeFactory
    let appScopeFactory: AppScopeFactory
    
    override init() {
        self.extensionScopeFactory = ProductionExtensionScopeFactory( domain: standardDomain )
        self.appScopeFactory = ProductionAppScopeFactory( extensionScopeFactory: extensionScopeFactory )
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }

}
