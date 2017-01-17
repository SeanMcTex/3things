//
//  TodayViewController.swift
//  3things Today
//
//  Created by Sean Mc Mains on 1/6/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, GoalsManagerDelegate, BEMCheckBoxDelegate {
    
    @IBOutlet weak var goal1Label: UILabel!
    @IBOutlet weak var goal2Label: UILabel!
    @IBOutlet weak var goal3Label: UILabel!
    
    @IBOutlet weak var goal1CheckBox: BEMCheckBox!
    @IBOutlet weak var goal2CheckBox: BEMCheckBox!
    @IBOutlet weak var goal3CheckBox: BEMCheckBox!
    
    private let goalsManager = GoalsManager(domain: standardDomain)
    private var completionHandler: ((NCUpdateResult) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.goalsManager.delegate = self
        self.goalsManager.fetchGoals()
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        
        configureCheckBoxes()
        configureGestureRecognizers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: @escaping ((NCUpdateResult) -> Void)) {
        self.completionHandler = completionHandler
        self.goalsManager.fetchGoals()
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == NCWidgetDisplayMode.compact {
            self.preferredContentSize = CGSize( width: maxSize.width, height: 200)
        } else {
            self.preferredContentSize = CGSize(width: maxSize.width, height: 200)
        }
    }
    
    // MARK: - Delegate Functions
    func didReceive(goals: [Goal]) {
        var newData = false
        for ( label, goal ) in zip( self.goalLabels(), goals ) {
            if label.text != goal.name {
                label.text = goal.name
                newData = true
            }
        }

        for ( checkBox, goal ) in zip( self.goalCheckBoxes(), goals ) {
            if checkBox.on != goal.completed {
                checkBox.on = goal.completed
                newData = true
            }
        }

        self.completionHandler?( newData ? NCUpdateResult.newData : NCUpdateResult.noData )
    }
    
    // MARK: - Helper Functions
    func goalLabels() -> [UILabel] {
        return [goal1Label, goal2Label, goal3Label]
    }
    
    func goalCheckBoxes() -> [BEMCheckBox] {
        return [goal1CheckBox, goal2CheckBox, goal3CheckBox]
    }
    
    func configureCheckBoxes() {
        for checkbox in goalCheckBoxes() {
            checkbox.onAnimationType = .fill
            checkbox.offAnimationType = .fill
        }
    }
    
    func configureGestureRecognizers() {
        for label in goalLabels() {
            let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                           action: #selector(didTriggerGestureRecognizer(_:)))
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    func didTriggerGestureRecognizer( _ sender: UITapGestureRecognizer ) {
        if let label = sender.view as? UILabel {
            for ( thisLabel, thisCheckBox ) in zip ( goalLabels(), goalCheckBoxes() ) {
                if label == thisLabel {
                    thisCheckBox.setOn(!thisCheckBox.on, animated: true)
                }
            }
        }
    }
    
    func persistGoals() {
        let goalNames = self.goalLabels().map { $0.text ?? "" }
        let goalCompletions = self.goalCheckBoxes().map { $0.on }
        let goals = zip( goalNames, goalCompletions ).map { Goal(completed: $0.1, name: $0.0 ) }
        
        self.goalsManager.store(goals: goals)
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        self.persistGoals()
    }

}
