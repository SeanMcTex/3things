//
//  OnboardingManager.swift
//  3things
//
//  Created by Sean Mc Mains on 2/6/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation

protocol OnboardingManagerDelegate: class {
    func didReceiveReminderRequest()
}

class OnboardingManager {
    public var enabled = true
    private let preferencesManager: PreferencesManager
    weak var delegate: OnboardingManagerDelegate?
    
    init( preferencesManager: PreferencesManager ) {
        self.preferencesManager = preferencesManager
    }
    
    func presentAlertIfNeeded(_ viewController: UIViewController) {
        guard enabled else {
            return
        }
        
        let preferencesManager = self.preferencesManager
        
        if !preferencesManager.appHasRunBefore {
            presentInitialWelcome( viewController )
        } else if !preferencesManager.hasAskedAboutTodayWidget && !preferencesManager.todayWidgetHasBeenDisplayed {
            presentTodayWidgetAlert( viewController )
        } else if !preferencesManager.hasAskedAboutNotifications {
            presentNotificationsAlert( viewController )
        }
    }
    
    private func presentInitialWelcome(_ viewController: UIViewController) {
        let title = NSLocalizedString("Welcome", comment: "Welcome dialog title")
        let message = NSLocalizedString("Thanks for trying 3things! To get started, think about the three most " +
            "important goals for you to accomplish today and enter them here.",
                                        comment: "Welcome dialog body text")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKText = NSLocalizedString("OK", comment: "Alert Dialog Confirmation Button Text")
        let action = UIAlertAction(title: OKText, style: .default)
        alertController.addAction( action )
        
        viewController.present(alertController, animated: true)
        self.preferencesManager.appHasRunBefore = true
    }
    
    private func presentTodayWidgetAlert(_ viewController: UIViewController) {
        let title = NSLocalizedString("Today Widget", comment: "Today Widget dialog title")
        let message = NSLocalizedString("Now that you've got some goals entered, you'll want to keep them in " +
            "front of you throughout your day. The easiest way to do that is with the Today Widget. To add it, swipe" +
            " down, then swipe all the way to the right, then select the \"Edit\" button at the bottom of that " +
            "screen. (You'll have dismiss this first.)",
                                        comment: "Today widget dialog body text")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKText = NSLocalizedString("OK", comment: "Alert Dialog Confirmation Button Text")
        let action = UIAlertAction(title: OKText, style: .default)
        alertController.addAction( action )
        
        viewController.present(alertController, animated: true)
        self.preferencesManager.hasAskedAboutTodayWidget = true
    }

    private func presentNotificationsAlert(_ viewController: UIViewController) {
        let title = NSLocalizedString("Notifications", comment: "Notifications dialog title")
        let message = NSLocalizedString("3things can also remind you each morning to set your goals for the day. " +
            "Would you like a reminder?",
                                        comment: "Welcome dialog body text")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let remindMe = NSLocalizedString("Remind Me", comment: "Notification Dialog Affirmative Button Text")
        let remindMeAction = UIAlertAction(title: remindMe, style: .default) { (_) in
            self.preferencesManager.hasAcceptedNotifications = true
            self.delegate?.didReceiveReminderRequest()
        }
        alertController.addAction( remindMeAction )
        
        let noThanks = NSLocalizedString("Not Now", comment: "Notification Dialog No Button Text")
        let noAction = UIAlertAction(title: noThanks, style: .cancel)
        alertController.addAction( noAction )
        
        viewController.present(alertController, animated: true)
        self.preferencesManager.hasAskedAboutNotifications = true
    }

}
