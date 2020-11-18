//
//  ViewController.swift
//  3things
//
//  Created by Sean Mc Mains on 1/5/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import UIKit
import SwiftUI

class EntryViewController: UIViewController, GoalsManagerDelegate, UITextFieldDelegate,
BEMCheckBoxDelegate, OnboardingManagerDelegate {
    
    public var goalsManager: GoalsManager?
    public var quotesManager: QuotesManager?
    
    @IBOutlet weak var goal1Field: UITextField!
    @IBOutlet weak var goal2Field: UITextField!
    @IBOutlet weak var goal3Field: UITextField!
    
    @IBOutlet weak var goal1CheckBox: BEMCheckBox!
    @IBOutlet weak var goal2CheckBox: BEMCheckBox!
    @IBOutlet weak var goal3CheckBox: BEMCheckBox!
    
    @IBOutlet weak var setGoalsButton: UIButton!
    @IBOutlet weak var shareGoalsButton: UIButton!
    
    @IBOutlet weak var quoteTextLabel: UILabel!
    @IBOutlet weak var quoteAttributionLabel: UILabel!
    
    // swiftlint:disable force_cast
    private let audioManager: AudioManager = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.appScopeFactory.audioManager()
    }()
    
    private let onboardingManager: OnboardingManager = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let onboardingManager = delegate.appScopeFactory.onboardingManager()
        return onboardingManager
    }()
    
    private let notificationsManager: NotificationsManager = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.appScopeFactory.notificationsManager()
    }()
    
    private let preferencesManager: PreferencesManager = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.appScopeFactory.preferencesManager()
    }()
    
    private let sharingManager: SharingManager = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.appScopeFactory.sharingManager()
    }()
    // swiftlint:enable force_cast
    
    private var isEditingActive: Bool {
        return self.goal1CheckBox.isHidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureGoalsManager()
        self.goalsManager?.fetchGoalsAndTimestamp()
        
        configureQuotes()
        configureCheckBoxes()
        
        onboardingManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        registerForNotifications()
        self.onboardingManager.presentAlertIfNeeded( self )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSetGoalsButton(_ sender: AnyObject) {
        toggleUIState()
        persistGoals( updatingTimestamp: true )
    }
    
    @IBAction func didTapShareGoalsButton(_ sender: Any) {
        self.sharingManager.share(goals: goalsFromUI(), in: self)
    }
    
    @IBAction func didTapSettingsButton(_ sender: Any) {
        let settings = preferencesManager.settings
        let settingsView = SettingsUIView( settings: settings ,
                                           dismissAction: {
                                            self.dismiss( animated: true, completion: nil )
                                            self.preferencesManager.settings = settings
                                            self.notificationsManager.scheduleReminder(
                                                areTodaysGoalsSet: false,
                                                reminderTime: settings.reminderTime
                                            )
        }
        )
        let settingsViewController = UIHostingController(rootView: settingsView )
        present( settingsViewController, animated: true )
    }
    
    // MARK: - Delegate Methods
    func didReceive(goals: [Goal], areGoalsCurrent: Bool) {
        for ( field, goal ) in zip( self.goalFields(), goals ) {
            field.text = goal.name
        }
        
        for ( checkbox, goal ) in zip( self.goalCheckBoxes(), goals ) {
            checkbox.on = goal.completed
        }
        
        if areGoalsCurrent {
            updateUIToGoalsEnteredState(animated: false)
        } else {
            updateUIToEditingState(animated: false)
        }
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        if checkBox.on {
            self.audioManager.play( sound: .checkOn )
        } else {
            self.audioManager.play( sound: .checkOff )
        }
        self.persistGoals( updatingTimestamp: false )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case goal1Field:
            clearAndActivate(field: goal2Field)
        case goal2Field:
            clearAndActivate(field: goal3Field)
        case goal3Field:
            toggleUIState()
            persistGoals( updatingTimestamp: true )
        default:
            break
        }
        return true
    }
    
    func didReceiveReminderRequest() {
        registerForNotifications()
        scheduleNotificationsIfWeHaveAsked()
    }
    
    // MARK: - Helper Methods
    func goalFields() -> [UITextField] {
        return [goal1Field, goal2Field, goal3Field]
    }
    
    func goalCheckBoxes() -> [BEMCheckBox] {
        return [goal1CheckBox, goal2CheckBox, goal3CheckBox]
    }
    
    func persistGoals( updatingTimestamp: Bool ) {
        let goals = goalsFromUI()
        
        if updatingTimestamp {
            self.goalsManager?.store(goals: goals, timestamp: Date() )
        } else {
            self.goalsManager?.store(goals: goals)
        }
        
        scheduleNotificationsIfWeHaveAsked()
    }
    
    func goalsFromUI() -> [Goal] {
        let goalNames = self.goalFields().map { $0.text ?? "" }
        let goalCompletions = self.goalCheckBoxes().map { $0.on }
        let goals = zip( goalNames, goalCompletions ).map { Goal(completed: $0.1, name: $0.0 ) }
        return goals
    }
    
    func toggleUIState() {
        if isEditingActive {
            for checkbox in goalCheckBoxes() {
                checkbox.on = false
            }
            updateUIToGoalsEnteredState(animated: true)
            self.onboardingManager.presentAlertIfNeeded( self )
        } else {
            updateUIToEditingState(animated: true)
        }
    }
    
    func updateUIToGoalsEnteredState(animated: Bool) {
        var delay = 0.0
        for ( field, checkbox ) in zip( goalFields(), goalCheckBoxes() ) {
            
            let animations = {
                field.isEnabled = false
                field.isAccessibilityElement = false
                field.isUserInteractionEnabled = false
                field.resignFirstResponder()
                
                checkbox.isHidden = false
                checkbox.alpha = 1.0
                let format = NSLocalizedString("%@ checkbox", comment: "accessibility label for checkbox")
                checkbox.accessibilityLabel = String(format: format, ( field.text ?? "Goal" ) )
                checkbox.setNeedsDisplay()
            }
            if animated {
                UIView.animate(withDuration: 0.3,
                               delay: delay,
                               options: UIView.AnimationOptions.curveEaseOut,
                               animations: animations,
                               completion: nil)
                delay += 0.1
            } else {
                animations()
            }
        }
        
        UIView.animate(withDuration: 0.5) {
            self.setGoalsButton.setTitle(NSLocalizedString("Revise Today's Goals", comment: ""), for: .normal)
            self.shareGoalsButton.alpha = 1.0
        }
    }
    
    func updateUIToEditingState(animated: Bool) {
        var delay = 0.0
        for ( field, checkbox ) in zip( goalFields(), goalCheckBoxes() ) {
            
            let animations = {
                field.isEnabled = true
                field.isAccessibilityElement = true
                field.isUserInteractionEnabled = true
                
                checkbox.isHidden = true
                checkbox.setNeedsDisplay()
                checkbox.alpha = 0.0
            }
            
            if animated {
                UIView.animate(withDuration: 0.3,
                               delay: delay,
                               options: UIView.AnimationOptions.curveEaseOut,
                               animations: animations,
                               completion: nil)
                delay += 0.1
            } else {
                animations()
            }
        }
        
        UIView.animate(withDuration: 0.5) {
            self.setGoalsButton.setTitle(NSLocalizedString("Set Today's Goals", comment: ""), for: .normal)
            self.shareGoalsButton.alpha = 0.0
        }
    }
    
    func clearAndActivate( field: UITextField ) {
        field.text = ""
        field.becomeFirstResponder()
    }
    
    func textFieldsAreEditing() -> Bool {
        return goalFields().reduce( false ) { (fieldsAreEditing, field) -> Bool in
            return fieldsAreEditing || field.isFirstResponder
        }
    }
    
    func configureGoalsManager() {
        self.goalsManager = GoalsManager(domain: standardDomain)
        self.goalsManager?.delegate = self
    }
    
    func configureCheckBoxes() {
        for checkbox in goalCheckBoxes() {
            checkbox.onAnimationType = .fill
            checkbox.offAnimationType = .fill
        }
    }
    
    func configureQuotes() {
        self.quotesManager = QuotesManager()
        if let quote = self.quotesManager?.randomQuote() {
            self.quoteTextLabel.text = quote.text
            self.quoteAttributionLabel.text = quote.attribution
        }
    }
    
    // MARK: - Notifications
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidComeToForeground),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }
    
    @objc func appDidComeToForeground() {
        if !textFieldsAreEditing() {
            self.goalsManager?.fetchGoalsAndTimestamp()
        }
    }
    
    func scheduleNotificationsIfWeHaveAsked() {
        if self.preferencesManager.hasAcceptedNotifications {
            self.notificationsManager.scheduleReminder(
                areTodaysGoalsSet: true, reminderTime:
                preferencesManager.settings.reminderTime
            )
        }
    }
}
